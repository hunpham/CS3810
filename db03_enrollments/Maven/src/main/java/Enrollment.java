/*
 * CS3810 - Principles of Database Systems - Spring 2021
 * Instructor: Thyago Mota
 * Description: DB 03 - Enrollment
 * Student(s) Name(s): Hung Pham
 */


import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "enrollments")
public class Enrollment {

    @EmbeddedId
    private EnrollmentPK enrollmentPK;

    @ManyToOne
    @MapsId("code")
    @JoinColumn(name = "code")
    private Course course;

    @ManyToOne
    @MapsId("id")
    @JoinColumn(name = "id")
    private Student student;

    public Enrollment() {
    }

    public Enrollment(EnrollmentPK enrollmentPK, Course course, Student student) {
        this.enrollmentPK = enrollmentPK;
        this.course = course;
        this.student = student;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public EnrollmentPK getEnrollmentPK() {
        return enrollmentPK;
    }

    public void setEnrollmentPK(EnrollmentPK enrollmentPK) {
        this.enrollmentPK = enrollmentPK;
    }

    @Override
    public String toString() {
        return "Enrollment{" +
                "enrollmentPK=" + enrollmentPK +
                ", course=" + course +
                ", student=" + student +
                '}';
    }
}
