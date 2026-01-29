import static spark.Spark.*;
import com.google.gson.Gson;

public class MonthlyFeeController {

    public static void registerRoutes() {

        get("/monthly-fees", (req, res) -> {
            res.type("application/json");
            return new Gson().toJson(
                MonthlyFeeDAO.getMonthlyFees()
            );
        });
    }
}
