package com.jessica.bicycleshopapp.model;

import java.time.LocalDate;

public class Order {
    private int productId;
    private int supplierId;
    private int quantity;
    private LocalDate orderDate;
    private LocalDate deliveryDate;

    public Order(int productId, int supplierId, int quantity, LocalDate orderDate, LocalDate deliveryDate) {
        this.productId = productId;
        this.supplierId = supplierId;
        this.quantity = quantity;
        this.orderDate = orderDate;
        this.deliveryDate = deliveryDate;
    }

    public int getProductId() { return productId; }
    public int getSupplierId() { return supplierId; }
    public int getQuantity() { return quantity; }
    public LocalDate getOrderDate() { return orderDate; }
    public LocalDate getDeliveryDate() { return deliveryDate; }
}
