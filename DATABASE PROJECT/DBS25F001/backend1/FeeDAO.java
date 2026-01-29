import java.sql.*;

public class FeeDAO {

    public static void showFeeStructure() {

        String sql =
                "SELECT f.fee_id, t.fee_type_name, f.amount " +
                "FROM fee_structure f " +
                "JOIN fee_types t ON f.fee_type_id = t.fee_type_id";

        try (Connection con = Database.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            System.out.println("\nFee ID | Type | Amount");
            System.out.println("--------------------------");

            while (rs.next()) {
                System.out.println(
                        rs.getInt(1) + " | " +
                        rs.getString(2) + " | " +
                        rs.getDouble(3)
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
