package com.techzone.dao;

import com.techzone.model.CartItem;
import com.techzone.model.Order;
import com.techzone.model.OrderItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

@Repository
public class OrderDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final org.springframework.jdbc.core.RowMapper<Order> orderMapper = (rs, rowNum) -> {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setFullName(rs.getString("full_name"));
        o.setPhone(rs.getString("phone"));
        o.setAddress(rs.getString("address"));
        o.setTotalAmount(rs.getLong("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setNote(rs.getString("note"));
        o.setCreatedAt(rs.getString("created_at"));
        return o;
    };

    private final org.springframework.jdbc.core.RowMapper<OrderItem> itemMapper = (rs, rowNum) -> {
        OrderItem i = new OrderItem();
        i.setId(rs.getInt("id"));
        i.setOrderId(rs.getInt("order_id"));
        i.setProductId(rs.getInt("product_id"));
        i.setProductName(rs.getString("product_name"));
        i.setPrice(rs.getLong("price"));
        i.setQuantity(rs.getInt("quantity"));
        return i;
    };

    @Transactional
    public int createOrder(int userId, String fullName, String phone, String address, String note,
            List<CartItem> cartItems) {
        long total = cartItems.stream().mapToLong(CartItem::getSubtotal).sum();

        String sqlOrder = "INSERT INTO orders (user_id, full_name, phone, address, total_amount, note) VALUES (?,?,?,?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(
                new PreparedStatementCreator() {
                    public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                        PreparedStatement ps = connection.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
                        ps.setInt(1, userId);
                        ps.setString(2, fullName);
                        ps.setString(3, phone);
                        ps.setString(4, address);
                        ps.setLong(5, total);
                        ps.setString(6, note);
                        return ps;
                    }
                },
                keyHolder);

        Number key = keyHolder.getKey();
        if (key == null)
            throw new RuntimeException("Không thể tạo đơn hàng: DB không trả về ID.");
        int orderId = key.intValue();

        String sqlItem = "INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES (?,?,?,?,?)";
        for (CartItem item : cartItems) {
            jdbcTemplate.update(sqlItem, orderId, item.getProductId(), item.getProduct().getName(),
                    item.getProduct().getPrice(), item.getQuantity());
        }

        return orderId;
    }

    public List<Order> getByUserId(int userId) {
        return jdbcTemplate.query("SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC", orderMapper,
                userId);
    }

    public List<Order> getAll() {
        return jdbcTemplate.query("SELECT * FROM orders ORDER BY created_at DESC", orderMapper);
    }

    public List<OrderItem> getItemsByOrderId(int orderId) {
        return jdbcTemplate.query("SELECT * FROM order_items WHERE order_id = ?", itemMapper, orderId);
    }

    public boolean updateStatus(int orderId, String status) {
        return jdbcTemplate.update("UPDATE orders SET status = ? WHERE id = ?", status, orderId) > 0;
    }

    public int count() {
        Integer result = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM orders", Integer.class);
        return result != null ? result : 0;
    }

    public long totalRevenue() {
        Long result = jdbcTemplate.queryForObject("SELECT SUM(total_amount) FROM orders WHERE status='delivered'",
                Long.class);
        return result != null ? result : 0;
    }

    public long revenueThisMonth() {
        Long result = jdbcTemplate.queryForObject(
                "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE status='delivered' AND MONTH(created_at)=MONTH(CURDATE()) AND YEAR(created_at)=YEAR(CURDATE())",
                Long.class);
        return result != null ? result : 0;
    }

    public long revenueLastMonth() {
        Long result = jdbcTemplate.queryForObject(
                "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE status='delivered' AND MONTH(created_at)=MONTH(DATE_SUB(CURDATE(),INTERVAL 1 MONTH)) AND YEAR(created_at)=YEAR(DATE_SUB(CURDATE(),INTERVAL 1 MONTH))",
                Long.class);
        return result != null ? result : 0;
    }

    public long ordersThisMonth() {
        Long result = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM orders WHERE MONTH(created_at)=MONTH(CURDATE()) AND YEAR(created_at)=YEAR(CURDATE())",
                Long.class);
        return result != null ? result : 0;
    }

    public List<Map<String, Object>> getTopSellingProducts() {
        return jdbcTemplate.queryForList(
                "SELECT oi.product_name, SUM(oi.quantity) AS total_qty, SUM(oi.price * oi.quantity) AS total_revenue " +
                        "FROM order_items oi JOIN orders o ON oi.order_id = o.id " +
                        "WHERE o.status = 'delivered' " +
                        "GROUP BY oi.product_name ORDER BY total_qty DESC LIMIT 5");
    }
}
