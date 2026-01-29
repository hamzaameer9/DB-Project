import static spark.Spark.*;

public class FeeController {

    public static void registerRoutes() {

        // GET all fees
        get("/fee-structure", (req, res) -> {
            res.type("application/json");
            return FeeDAO.getAllFees();
        });

        // ADD / UPDATE fee
        post("/fee-structure", (req, res) -> {

            int feeTypeId =
                Integer.parseInt(req.queryParams("feeTypeId"));

            double amount =
                Double.parseDouble(req.queryParams("amount"));

            FeeDAO.saveFee(feeTypeId, amount);

            return "Fee saved";
        });
    }
}
