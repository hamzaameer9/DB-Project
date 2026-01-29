import static spark.Spark.*;
import com.google.gson.Gson;

public class StudentController {

    public static void registerRoutes() {

        Gson gson = new Gson();

        before((req, res) -> {
            res.header("Access-Control-Allow-Origin", "*");
            res.header("Access-Control-Allow-Methods", "GET,POST,DELETE,OPTIONS");
            res.header("Access-Control-Allow-Headers", "Content-Type");
        });

        options("/*", (req, res) -> "OK");

        get("/students", (req, res) -> {
            res.type("application/json");
            return gson.toJson(StudentDAO.getAllStudents());
        });

        post("/students", (req, res) -> {
            Student s = gson.fromJson(req.body(), Student.class);

            boolean ok = StudentDAO.addStudent(
                    s.name, s.roll_no, s.class_id, s.section_id, s.status);

            return ok ? "SUCCESS" : "ERROR";
        });

        delete("/students/:id", (req, res) -> {
            int id = Integer.parseInt(req.params("id"));
            return StudentDAO.deleteStudent(id) ? "DELETED" : "ERROR";
        });
    }

    static class Student {
        String name;
        String roll_no;
        int class_id;
        int section_id;
        String status;
    }
}
