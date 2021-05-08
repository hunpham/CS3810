import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/*
 * CS3810 - Principles of Database Systems - Spring 2021
 * Instructor: Thyago Mota
 * Description: DB 03 - Student
 * Student(s) Name(s): Hung Pham
 */

@Entity
@Table(name = "courses")
public class Course {

    @Id
    private String code;

    private String title;

    private String instructor;

    private int max;

    private int actual;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }

    public int getActual() {
        return actual;
    }

    public void setActual(int actual) {
        this.actual = actual;
    }

    @Override
    public String toString() {
        return String.format("%-7s|%-35s|%-15s|%03d| %03d  | %03d ",
                code, title, instructor, max, actual, max - actual);
    }
}
