package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.entity.Product;
import com.util.DBConnect;

public class ProductDao {

	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private Product product = null;
	private List<Product> list = new ArrayList<Product>();
	private boolean f = false;

	public ProductDao() {
		conn = DBConnect.getConnection();
	}

	public boolean addProduct(Product p) {
		String sql = "insert into product(title,description,category,price,stock,image) values(?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p.getTitle());
			ps.setString(2, p.getDescription());
			ps.setString(3, p.getCategory());
			ps.setString(4, p.getPrice());
			ps.setInt(5, p.getStock());
			ps.setString(6, p.getImage());
			int i = ps.executeUpdate();
			if (i == 1)
				f = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean updateProduct(Product p) {
		String sql = "update product set title=?,description=?,category=?,price=?,stock=?,image=? where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p.getTitle());
			ps.setString(2, p.getDescription());
			ps.setString(3, p.getCategory());
			ps.setString(4, p.getPrice());
			ps.setInt(5, p.getStock());
			ps.setString(6, p.getImage());
			ps.setInt(7, p.getId());
			int i = ps.executeUpdate();
			if (i == 1)
				f = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean updateProductStock(int id, int stock) {
		String sql = "update product set stock=? where id=?";
		int st;

		if (stock <= 0) {
			st = 0;
		} else {
			st = stock;
		}

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, st);
			ps.setInt(2, id);
			int i = ps.executeUpdate();
			if (i == 1)
				f = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteProduct(int id) {
		String sql = "delete from product where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			int i = ps.executeUpdate();
			if (i == 1)
				f = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<Product> getAllProduct() {
		String sql = "select * from product order by id desc";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getInt(6), rs.getString(7));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Product> getProductBySearch(String ch) {
		String sql = "select * from product where title like ? or description like ? or category like ? order by id desc";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + ch + "%");
			ps.setString(2, "%" + ch + "%");
			ps.setString(3, "%" + ch + "%");
			rs = ps.executeQuery();

			while (rs.next()) {
				product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getInt(6), rs.getString(7));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Product getProductByid(int id) {
		String sql = "select * from product where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			while (rs.next()) {
				product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getInt(6), rs.getString(7));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return product;
	}

	public List<Product> getProductByCategory(String category) {
		try {

			if (category.equals("all")) {
				String sql = "select * from product order by id desc";
				ps = conn.prepareStatement(sql);
			} else {
				String sql = "select * from product where category=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, category);

			}

			rs = ps.executeQuery();
			while (rs.next()) {
				product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getInt(6), rs.getString(7));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

}
