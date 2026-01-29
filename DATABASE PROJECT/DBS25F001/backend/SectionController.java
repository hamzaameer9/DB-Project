import static spark.Spark.*;

public class SectionController {

    public static void registerRoutes() {

        get("/sections", (req, res) -> {
            res.type("application/json");
            return SectionDAO.getAllSections();
        });
    }
}
