import java.sql.Connection;
import java.sql.DriverManager;

public class Database {

    private static final String URL =
            "jdbc:mysql://localhost:3306/school_fee_management?useSSL=false&serverTimezone=UTC";

    private static final String USER = "root";
    private static final String PASSWORD = "root123";   // put your MySQL password if any

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
