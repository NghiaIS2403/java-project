package com.techzone.model;

public class CartItem {
    private int productId, quantity;
    private Product product;

    public CartItem() {}
    public CartItem(int productId, int quantity) {
        this.productId = productId;
        this.quantity  = quantity;
    }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public long getSubtotal() {
        return product != null ? product.getPrice() * quantity : 0;
    }
    public String getFormattedSubtotal() {
        return String.format("%,d", getSubtotal()).replace(",", ".") + "đ";
    }
}
