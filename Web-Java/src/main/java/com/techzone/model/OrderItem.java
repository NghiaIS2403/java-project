package com.techzone.model;

public class OrderItem {
    private int id, orderId, productId, quantity;
    private String productName;
    private long price;

    public OrderItem() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }

    public long getSubtotal() { return price * quantity; }

    public String getFormattedPrice() {
        return String.format("%,d", price).replace(",", ".") + "đ";
    }
    public String getFormattedSubtotal() {
        return String.format("%,d", getSubtotal()).replace(",", ".") + "đ";
    }
}
