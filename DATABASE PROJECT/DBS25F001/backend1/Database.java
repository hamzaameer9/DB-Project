import java.sql.*;

public class Database {

    private static final String URL =
            "jdbc:mysql://localhost:3306/school_fee_management";

    private static final String USER = "root";
    private static final String PASSWORD = "root123";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
