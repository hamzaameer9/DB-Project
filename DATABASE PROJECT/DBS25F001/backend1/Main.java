import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        while (true) {

            System.out.println("\n==============================");
            System.out.println(" SCHOOL FEE MANAGEMENT SYSTEM");
            System.out.println("==============================");
            System.out.println("1. Add Student");
            System.out.println("2. View Students");
            System.out.println("3. Delete Student");
            System.out.println("4. Fee Structure");
            System.out.println("5. Monthly Fees");
            System.out.println("0. Exit");
            System.out.print("Choice: ");

            int ch = sc.nextInt();

            switch (ch) {

                case 1:
                    sc.nextLine();
                    System.out.print("Name: ");
                    String name = sc.nextLine();

                    System.out.print("Roll No: ");
                    String roll = sc.nextLine();

                    System.out.print("Class ID: ");
                    int classId = sc.nextInt();

                    System.out.print("Section ID: ");
                    int sectionId = sc.nextInt();

                    StudentDAO.addStudent(name, roll, classId, sectionId);
                    break;

                case 2:
                    StudentDAO.showStudents();
                    break;

                case 3:
                    System.out.print("Student ID: ");
                    int id = sc.nextInt();
                    StudentDAO.deleteStudent(id);
                    break;

                case 4:
                    FeeDAO.showFeeStructure();
                    break;

                case 5:
                    MonthlyFeeDAO.showMonthlyFees();

                    break;

                case 0:
                    System.out.println("Good bye ");
                    System.exit(0);

                default:
                    System.out.println("Invalid option");
            }
        }
    }
}
