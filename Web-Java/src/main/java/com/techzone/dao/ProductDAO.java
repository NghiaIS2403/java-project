package com.techzone.dao;

import com.techzone.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Product> rowMapper = (rs, rowNum) -> {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setCategory(rs.getString("category"));
        p.setBrand(rs.getString("brand"));
        p.setPrice(rs.getLong("price"));
        p.setOldPrice(rs.getLong("old_price"));
        p.setDescription(rs.getString("description"));
        p.setSpecs(rs.getString("specs"));
        p.setEmoji(rs.getString("emoji"));
        p.setBadge(rs.getString("badge"));
        p.setStock(rs.getInt("stock"));
        p.setRating(rs.getDouble("rating"));
        p.setReviews(rs.getInt("reviews"));
        return p;
    };

    public List<Product> getAll() {
        return jdbcTemplate.query("SELECT * FROM products ORDER BY id", rowMapper);
    }

    public List<Product> getByCategory(String category) {
        return jdbcTemplate.query("SELECT * FROM products WHERE category = ? ORDER BY id", rowMapper, category);
    }

    public List<Product> search(String keyword) {
        String sql = "SELECT * FROM products WHERE name LIKE ? OR brand LIKE ? OR category LIKE ? ORDER BY id";
        String kw = "%" + keyword + "%";
        return jdbcTemplate.query(sql, rowMapper, kw, kw, kw);
    }

    public Product getById(int id) {
        List<Product> list = jdbcTemplate.query("SELECT * FROM products WHERE id = ?", rowMapper, id);
        return list.isEmpty() ? null : list.get(0);
    }

    public List<String> getCategories() {
        return jdbcTemplate.queryForList("SELECT DISTINCT category FROM products ORDER BY category", String.class);
    }

    public boolean insert(Product p) {
        String sql = "INSERT INTO products (name,category,brand,price,old_price,description,specs,emoji,badge,stock,rating,reviews) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
        return jdbcTemplate.update(sql, p.getName(), p.getCategory(), p.getBrand(), p.getPrice(), p.getOldPrice(),
                p.getDescription(), p.getSpecs(), p.getEmoji(), p.getBadge(), p.getStock(), p.getRating(),
                p.getReviews()) > 0;
    }

    public boolean update(Product p) {
        String sql = "UPDATE products SET name=?,category=?,brand=?,price=?,old_price=?,description=?,specs=?,emoji=?,badge=?,stock=? WHERE id=?";
        return jdbcTemplate.update(sql, p.getName(), p.getCategory(), p.getBrand(), p.getPrice(), p.getOldPrice(),
                p.getDescription(), p.getSpecs(), p.getEmoji(), p.getBadge(), p.getStock(), p.getId()) > 0;
    }

    public boolean delete(int id) {
        return jdbcTemplate.update("DELETE FROM products WHERE id = ?", id) > 0;
    }

    public int count() {
        Integer result = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM products", Integer.class);
        return result != null ? result : 0;
    }
}
