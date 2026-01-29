import java.sql.*;
import java.util.*;

public class StudentDAO {

    public static List<Map<String, Object>> getAllStudents() {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = """
            SELECT s.student_id, s.name, s.roll_no,
                   c.class_name, sec.section_name, s.status
            FROM students s
            JOIN classes c ON s.class_id = c.class_id
            JOIN sections sec ON s.section_id = sec.section_id
        """;

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("student_id", rs.getInt("student_id"));
                row.put("name", rs.getString("name"));
                row.put("roll_no", rs.getString("roll_no"));
                row.put("class", rs.getString("class_name"));
                row.put("section", rs.getString("section_name"));
                row.put("status", rs.getString("status"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean addStudent(String name, String roll,
                                     int classId, int sectionId, String status) {

        String sql = """
            INSERT INTO students(name, roll_no, class_id, section_id, status)
            VALUES (?, ?, ?, ?, ?)
        """;

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, roll);
            ps.setInt(3, classId);
            ps.setInt(4, sectionId);
            ps.setString(5, status);

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteStudent(int id) {
        try (Connection con = Database.getConnection();
             PreparedStatement ps =
                     con.prepareStatement("DELETE FROM students WHERE student_id=?")) {

            ps.setInt(1, id);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
