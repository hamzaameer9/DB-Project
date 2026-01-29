public class MonthlyFee {

    public int monthly_fee_id;
    public int student_id;
    public String month;
    public double amount;
    public String due_date;
    public String status;

    public MonthlyFee(int id, int studentId, String month,
                      double amount, String dueDate, String status) {

        this.monthly_fee_id = id;
        this.student_id = studentId;
        this.month = month;
        this.amount = amount;
        this.due_date = dueDate;
        this.status = status;
    }
}
