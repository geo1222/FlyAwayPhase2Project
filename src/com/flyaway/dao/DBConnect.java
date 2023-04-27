package com.flyaway.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

	public static Connection getConnection() throws SQLException {

		Connection con = null;
		String jdbcUrl = "jdbc:mysql://localhost:3306/flight_reservation_db?useSSL=false";
		String driver = "com.mysql.cj.jdbc.Driver";
		String user = "root";
		String password = "Simplilearn";


		try
		{
			Class.forName(driver);
			con = DriverManager.getConnection(jdbcUrl, user, password);

		}catch(Exception e)
		{

			e.printStackTrace();
		}

		return con;
	}

	/*
	public static void main(String[] args) {

			getConnection();
			System.out.println("Connection Established");

	}
	 */

}
