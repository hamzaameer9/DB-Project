public class Student {

    public int id;
    public String name;
    public String rollNo;
    public int classId;
    public int sectionId;
    public String status;

    public Student(int id, String name, String rollNo,
                   int classId, int sectionId, String status) {

        this.id = id;
        this.name = name;
        this.rollNo = rollNo;
        this.classId = classId;
        this.sectionId = sectionId;
        this.status = status;
    }
}
