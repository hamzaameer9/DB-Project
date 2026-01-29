import static spark.Spark.*;

public class ClassController {

    public static void registerRoutes() {

        get("/classes", (req, res) -> {
            res.type("application/json");
            return ClassDAO.getAllClasses();
        });
    }
}
