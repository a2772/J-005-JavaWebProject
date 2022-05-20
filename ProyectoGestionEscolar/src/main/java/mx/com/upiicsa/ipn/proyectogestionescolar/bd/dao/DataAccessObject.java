package mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import mx.com.upiicsa.ipn.proyectogestionescolar.bd.Conexion;

public class DataAccessObject {
    protected static final String DRIVER = Conexion.MySQL.getDriver();
    protected static final String URL = Conexion.MySQL.getUrl();
    protected static final String USER = Conexion.MySQL.getUser();
    protected static final String PASSWORD = Conexion.MySQL.getPassword();
    protected Connection connection = null;
    
    public DataAccessObject() throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER);
        connection = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("CONEXIÓN ABIERTA");
    }

    public Statement createStatement() throws SQLException, DAOInitializationException {
        if (connection == null || connection.isClosed()) {
            throw new DAOInitializationException("ERROR. El DAO fue cerrado previamente.");
        } else {
            return connection.createStatement();
        }
    }
    
    public PreparedStatement prepareStatement(String sql) throws SQLException, DAOInitializationException {
        if (connection == null || connection.isClosed()) {
            throw new DAOInitializationException("ERROR. El DAO fue cerrado previamente.");
        } else {
            return connection.prepareStatement(sql);
        }
    }
    
    public void closeConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                throw new DAOInitializationException("ERROR. El DAO fue cerrado previamente.");
            } else {
                connection.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    public Connection getConnection() throws SQLException, ClassNotFoundException, DAOInitializationException {
        if (connection == null || connection.isClosed()) {
            throw new DAOInitializationException("ERROR. El DAO fue cerrado previamente.");
        }
        return connection;
    }

    public void closeStatement(Statement stmt) throws SQLException, DAOInitializationException {
        if (connection == null || connection.isClosed()) {
            throw new DAOInitializationException("ERROR. El DAO fue cerrado previamente.");
        }

        if (stmt != null && !stmt.isClosed()) {
            stmt.close();
        }
    }
    
    public void closeResultSet(ResultSet rs) throws SQLException, DAOInitializationException {
        if (connection == null || connection.isClosed()) {
            throw new DAOInitializationException("ERROR. El DAO fue cerrado previamente.");
        }

        if (rs != null && !rs.isClosed()) {
            rs.close();
        }
    }
}
