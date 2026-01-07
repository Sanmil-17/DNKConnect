package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Cart;
import com.util.DBConnect;

public class CartDAO {
	private Connection conn;

	public CartDAO() {
		conn = DBConnect.getConnection();
	}

	public boolean addCart(int pId, int userId) {
		boolean f = false;
		try {
			String sql = "insert into cart(product_id,user_id,quantity) values(?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, pId);
			ps.setInt(2, userId);
			ps.setInt(3, 1);

			int id = ps.executeUpdate();
			if (id == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean checkCart(int pId, int userId) {
		boolean f = false;
		try {
			String sql = "select * from cart where product_id=? and user_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, pId);
			ps.setInt(2, userId);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public int countCart(int userId) {
		int i = 0;
		try {
			String sql = "select * from cart where user_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}

	public List<Cart> getCart(int userId) {
		List<Cart> list = new ArrayList<Cart>();
		Cart cart = null;
		try {
			String sql = "select * from cart where user_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				cart = new Cart(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4));
				list.add(cart);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean updateQuantity(String sql) {
		boolean f = false;
		try {

			PreparedStatement ps = conn.prepareStatement(sql);
			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteCart(int id) {
		boolean f = false;
		try {
			String sql = "delete from cart where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	 public boolean clearCart(int userId) {
	        try {
	            String sql = "DELETE FROM cart WHERE user_id=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setInt(1, userId);
	            ps.executeUpdate(); // no need to check rows deleted
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

}
