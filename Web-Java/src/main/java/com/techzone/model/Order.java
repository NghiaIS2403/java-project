package com.techzone.model;

import java.util.List;

public class Order {
    private int id, userId;
    private String fullName, phone, address, status, note, createdAt;
    private long totalAmount;
    private List<OrderItem> items;

    public Order() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public long getTotalAmount() { return totalAmount; }
    public void setTotalAmount(long totalAmount) { this.totalAmount = totalAmount; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    public String getFormattedTotal() {
        return String.format("%,d", totalAmount).replace(",", ".") + "đ";
    }

    public String getStatusLabel() {
        switch (status) {
            case "pending":    return "Chờ xác nhận";
            case "processing": return "Đang xử lý";
            case "delivered":  return "Đã giao";
            case "cancelled":  return "Đã hủy";
            default:           return status;
        }
    }
}
