package com.techzone.model;

public class Product {
    private int id;
    private String name, category, brand, description, specs, emoji, badge;
    private long price, oldPrice;
    private int stock, reviews;
    private double rating;

    public Product() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getSpecs() { return specs; }
    public void setSpecs(String specs) { this.specs = specs; }

    public String getEmoji() { return emoji; }
    public void setEmoji(String emoji) { this.emoji = emoji; }

    public String getBadge() { return badge; }
    public void setBadge(String badge) { this.badge = badge; }

    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }

    public long getOldPrice() { return oldPrice; }
    public void setOldPrice(long oldPrice) { this.oldPrice = oldPrice; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public int getReviews() { return reviews; }
    public void setReviews(int reviews) { this.reviews = reviews; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    /** Trả về giá đã định dạng kiểu "29.990.000đ" */
    public String getFormattedPrice() {
        return String.format("%,d", price).replace(",", ".") + "đ";
    }
    public String getFormattedOldPrice() {
        return oldPrice > 0 ? String.format("%,d", oldPrice).replace(",", ".") + "đ" : "";
    }

    /** Tính % giảm giá */
    public int getDiscountPercent() {
        if (oldPrice <= 0) return 0;
        return (int) Math.round((1.0 - (double) price / oldPrice) * 100);
    }
}
