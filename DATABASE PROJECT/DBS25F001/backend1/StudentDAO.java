import java.sql.*;

public class StudentDAO {

    public static void addStudent(String name, String roll,
                                  int classId, int sectionId) {

        String sql =
                "INSERT INTO students(name, roll_no, class_id, section_id) " +
                "VALUES (?,?,?,?)";

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, roll);
            ps.setInt(3, classId);
            ps.setInt(4, sectionId);

            ps.executeUpdate();
            System.out.println(" Student added successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void showStudents() {

        String sql = "SELECT * FROM students";

        try (Connection con = Database.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            System.out.println("\nID | Name | Roll | Class | Section | Status");
            System.out.println("-----------------------------------------------");

            while (rs.next()) {
                System.out.println(
                        rs.getInt("student_id") + " | " +
                        rs.getString("name") + " | " +
                        rs.getString("roll_no") + " | " +
                        rs.getInt("class_id") + " | " +
                        rs.getInt("section_id") + " | " +
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteStudent(int id) {

        String sql = "DELETE FROM students WHERE student_id=?";

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

            System.out.println("🗑 Student deleted");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
