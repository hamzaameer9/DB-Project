public class MonthlyFee {

    public int id;
    public int studentId;
    public String month;
    public double amount;
    public String dueDate;
    public String status;

    public MonthlyFee(int id, int studentId, String month,
                      double amount, String dueDate, String status) {

        this.id = id;
        this.studentId = studentId;
        this.month = month;
        this.amount = amount;
        this.dueDate = dueDate;
        this.status = status;
    }
}
