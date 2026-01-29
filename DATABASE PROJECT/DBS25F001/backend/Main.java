import static spark.Spark.*;

public class Main {

    public static void main(String[] args) {

        port(4567);

        before((req, res) -> {
            res.type("application/json");
        });

        options("/*", (req, res) -> "OK");

        System.out.println("Server running at http://localhost:4567");

        StudentController.registerRoutes();
        ClassController.registerRoutes();
        SectionController.registerRoutes();
        FeeController.registerRoutes();
        MonthlyFeeController.registerRoutes();
    }
}
