package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ServletCRUDMVC";
    private final String portNumber = "1433";
    private final String instance = ""; // MSSQLSERVER LEAVE THIS ONE EMPTY IF YOUR SQL IS A SINGLE INSTANCE
    private final String userID = "phusy";
    private final String password = "1234@abc";

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance
                + ";databaseName=" + dbName + ";trustServerCertificate=true;";
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                    + ";databaseName=" + dbName + ";trustServerCertificate=true;";
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        try {
            return DriverManager.getConnection(url, userID, password);
        } catch (Exception e) {
            // Thử kết nối bổ sung bằng Windows Authentication nếu sa chưa bật
            try {
                String winUrl = "jdbc:sqlserver://" + serverName + ":" + portNumber
                        + ";databaseName=" + dbName + ";integratedSecurity=true;trustServerCertificate=true;";
                return DriverManager.getConnection(winUrl);
            } catch (Exception ex) {
                throw e;
            }
        }
    }

    public static void main(String[] args) {
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("Ket noi co so du lieu ServletCRUDMVC thanh cong!");
                conn.close();
            } else {
                System.out.println("Ket noi that bai!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}