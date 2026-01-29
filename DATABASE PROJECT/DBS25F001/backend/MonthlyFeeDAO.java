import java.sql.*;
import java.util.*;

public class MonthlyFeeDAO {

    public static List<Map<String, Object>> getMonthlyFees() {

        List<Map<String, Object>> list = new ArrayList<>();

        String sql =
            "SELECT mf.monthly_fee_id, " +
            "       mf.student_id, " +
            "       s.name AS student_name, " +
            "       mf.month, " +
            "       mf.fee_id, " +
            "       fs.amount, " +
            "       mf.due_date, " +
            "       mf.status " +
            "FROM monthly_fee mf " +
            "JOIN students s ON s.student_id = mf.student_id " +
            "JOIN fee_structure fs ON fs.fee_id = mf.fee_id";

        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();

                row.put("monthly_fee_id", rs.getInt("monthly_fee_id"));
                row.put("student_id", rs.getInt("student_id"));
                row.put("student_name", rs.getString("student_name"));
                row.put("month", rs.getString("month"));
                row.put("fee_id", rs.getInt("fee_id"));
                row.put("amount", rs.getDouble("amount"));
                row.put("due_date", rs.getDate("due_date"));
                row.put("status", rs.getString("status"));

                list.add(row);
            }

            System.out.println("MONTHLY FEES LOADED = " + list.size());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
