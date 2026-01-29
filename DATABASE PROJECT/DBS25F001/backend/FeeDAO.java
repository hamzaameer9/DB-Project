import java.sql.*;
import java.util.*;

public class FeeDAO {

    public static List<Map<String, Object>> getAllFees() throws Exception {

        Connection con = Database.getConnection();

        String sql = """
            SELECT 
                fs.fee_id,
                ft.fee_type_id,
                ft.fee_type_name,
                fs.amount
            FROM fee_structure fs
            JOIN fee_types ft
                ON fs.fee_type_id = ft.fee_type_id
        """;

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql);

        List<Map<String, Object>> list = new ArrayList<>();

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("fee_id", rs.getInt("fee_id"));
            row.put("fee_type_id", rs.getInt("fee_type_id"));
            row.put("fee_type_name", rs.getString("fee_type_name"));
            row.put("amount", rs.getDouble("amount"));
            list.add(row);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    public static void saveFee(int feeTypeId, double amount)
            throws Exception {

        Connection con = Database.getConnection();

        PreparedStatement ps = con.prepareStatement("""
            INSERT INTO fee_structure (fee_type_id, amount)
            VALUES (?, ?)
            ON DUPLICATE KEY UPDATE amount=?
        """);

        ps.setInt(1, feeTypeId);
        ps.setDouble(2, amount);
        ps.setDouble(3, amount);

        ps.executeUpdate();

        ps.close();
        con.close();
    }
}
