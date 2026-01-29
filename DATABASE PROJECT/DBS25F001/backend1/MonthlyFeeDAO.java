import java.sql.*;

public class MonthlyFeeDAO {

    public static void showMonthlyFees() {

        String sql =
            "SELECT mf.monthly_fee_id, mf.student_id, mf.month, " +
            "fs.amount, mf.due_date, mf.status " +
            "FROM monthly_fee mf " +
            "JOIN fee_structure fs ON mf.fee_id = fs.fee_id";

        try (
            Connection con = Database.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql)
        ) {

            System.out.println("\nMonthlyFeeID | StudentID | Month | Amount | Due Date | Status");
            System.out.println("----------------------------------------------------------------");

            while (rs.next()) {

                System.out.println(
                    rs.getInt("monthly_fee_id") + " | " +
                    rs.getInt("student_id") + " | " +
                    rs.getString("month") + " | " +
                    rs.getDouble("amount") + " | " +
                    rs.getDate("due_date") + " | " +
                    rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
