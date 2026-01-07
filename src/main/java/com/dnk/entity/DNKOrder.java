package com.dnk.entity;

import java.sql.Timestamp;

public class DNKOrder {
    private int id;
    private String orderId;
    private String courierName;
    private String trackingNumber;
    private String shippingStatus;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public DNKOrder() {}

    // Constructor to initialize fields
    public DNKOrder(int id, String orderId, String courierName, String trackingNumber, 
                    String shippingStatus, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.orderId = orderId;
        this.courierName = courierName;
        this.trackingNumber = trackingNumber;
        this.shippingStatus = shippingStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCourierName() {
        return courierName;
    }

    public void setCourierName(String courierName) {
        this.courierName = courierName;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
