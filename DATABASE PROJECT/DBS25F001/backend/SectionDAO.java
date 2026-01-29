import java.sql.*;
import java.util.*;

public class SectionDAO {

    public static List<Map<String, Object>> getAllSections() throws Exception {

        Connection con = Database.getConnection();
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery(
            "SELECT section_id, section_name FROM sections"
        );

        List<Map<String, Object>> list = new ArrayList<>();

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("section_id", rs.getInt("section_id"));
            row.put("section_name", rs.getString("section_name"));
            list.add(row);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }
}
