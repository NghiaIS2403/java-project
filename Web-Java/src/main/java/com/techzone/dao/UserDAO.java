package com.techzone.dao;

import com.techzone.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<User> rowMapper = (rs, rowNum) -> {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setRole(rs.getString("role"));
        u.setCreatedAt(rs.getString("created_at"));
        return u;
    };

    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        List<User> list = jdbcTemplate.query(sql, rowMapper, email, password);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean register(User u) {
        if (emailExists(u.getEmail()))
            return false;
        String sql = "INSERT INTO users (name, email, password, phone, address, role) VALUES (?,?,?,?,?,'user')";
        return jdbcTemplate.update(sql, u.getName(), u.getEmail(), u.getPassword(), u.getPhone(), u.getAddress()) > 0;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        List<Integer> ids = jdbcTemplate.queryForList(sql, Integer.class, email);
        return !ids.isEmpty();
    }

    public List<User> getAll() {
        return jdbcTemplate.query("SELECT * FROM users ORDER BY id", rowMapper);
    }

    public User getById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        List<User> list = jdbcTemplate.query(sql, rowMapper, id);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean delete(int id) {
        return jdbcTemplate.update("DELETE FROM users WHERE id = ?", id) > 0;
    }

    public int count() {
        Integer result = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users", Integer.class);
        return result != null ? result : 0;
    }
}
