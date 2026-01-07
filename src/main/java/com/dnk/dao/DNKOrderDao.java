package com.dnk.dao;

import com.dnk.entity.DNKOrder;
import com.util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DNKOrderDao {

    // Save a new DNK order
    public boolean saveDNKOrder(DNKOrder order) {
        String sql = "INSERT INTO dnk_order (order_id, courier_name, tracking_number, shipping_status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, order.getOrderId());
            ps.setString(2, order.getCourierName());
            ps.setString(3, order.getTrackingNumber());
            ps.setString(4, order.getShippingStatus());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Fetch all DNK orders
    public List<DNKOrder> getAllDNKOrders() {
        List<DNKOrder> list = new ArrayList<>();
        String sql = "SELECT * FROM dnk_order";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DNKOrder o = new DNKOrder();
                o.setId(rs.getInt("id"));
                o.setOrderId(rs.getString("order_id"));
                o.setCourierName(rs.getString("courier_name"));
                o.setTrackingNumber(rs.getString("tracking_number"));
                o.setShippingStatus(rs.getString("shipping_status"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
                o.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Fetched Orders: " + list.size());  // Log the size of the list
        return list;
    }

    // Update the shipping status for an existing DNK order by ID
    public boolean updateShippingStatus(int id, String status) {
        String sql = "UPDATE dnk_order SET shipping_status=? WHERE id=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get a DNK order by order ID
    public DNKOrder getDNKOrderByOrderId(String orderId) {
        DNKOrder order = null;
        String sql = "SELECT * FROM dnk_order WHERE order_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new DNKOrder();
                    order.setId(rs.getInt("id"));
                    order.setOrderId(rs.getString("order_id"));
                    order.setCourierName(rs.getString("courier_name"));
                    order.setTrackingNumber(rs.getString("tracking_number"));
                    order.setShippingStatus(rs.getString("shipping_status"));
                    order.setCreatedAt(rs.getTimestamp("created_at"));
                    order.setUpdatedAt(rs.getTimestamp("updated_at"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    // Update an existing DNK order
    public boolean updateDNKOrder(DNKOrder dnkOrder) {
        String sql = "UPDATE dnk_order SET courier_name = ?, tracking_number = ?, shipping_status = ?, updated_at = NOW() WHERE order_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dnkOrder.getCourierName());
            ps.setString(2, dnkOrder.getTrackingNumber());
            ps.setString(3, dnkOrder.getShippingStatus());
            ps.setString(4, dnkOrder.getOrderId());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Insert a new DNK order
    public boolean insertDNKOrder(DNKOrder order) {
        String sql = "INSERT INTO dnk_order (order_id, courier_name, tracking_number, shipping_status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, order.getOrderId());
            ps.setString(2, order.getCourierName());
            ps.setString(3, order.getTrackingNumber());
            ps.setString(4, order.getShippingStatus());
            System.out.println("*********" + sql);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
