import java.sql.*;
import java.util.*;

public class ClassDAO {

    public static List<Map<String, Object>> getAllClasses() throws Exception {

        Connection con = Database.getConnection();
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery(
            "SELECT class_id, class_name FROM classes"
        );

        List<Map<String, Object>> list = new ArrayList<>();

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("class_id", rs.getInt("class_id"));
            row.put("class_name", rs.getString("class_name"));
            list.add(row);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }
}
