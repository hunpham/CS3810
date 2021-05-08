/*
 * CS3810 - Principles of Database Systems - Spring 2021
 * Instructor: Thyago Mota
 * Description: DB 03 - Controller
 * Student(s) Name(s): Hung Pham
 */

import org.hibernate.Session;
import org.hibernate.internal.SessionImpl;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaQuery;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class Controller {

    private EntityManager em;
    private Session session;

    public Controller() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("db03");
        em = emf.createEntityManager();
        session = em.unwrap(Session.class);
    }

    // TODO: return a Student entity from the given id (or null if the entity does not exist)
    public Student getStudent(int id) {
        Student student = em.find(Student.class, id);
        if (student == null)
            return null;
        else
            return student;
    }

    // TODO: add the given student entity, returning true/false depending whether the operation was successful or not
    public boolean addStudent(final Student student) {
        try {
            em.getTransaction().begin();
            em.persist(student);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // TODO: return a list of all Course entities
    public List<Course> getCourses() {
        List<Course> courses = new LinkedList<>();
        Query query = em.createQuery("SELECT c FROM Course c");
        for (Object obj : query.getResultList()) {
            Course c = (Course) obj;
            em.refresh(c);
            courses.add(c);
        }
        return courses;
    }

    // TODO: enroll a student to a course based on the given parameters, returning true/false depending whether the operation was successful or not
    public boolean enrollStudent(String code, int id) {
        try {
            session.beginTransaction();
//        EnrollmentPK key = new EnrollmentPK(code, id);
            Course c = em.find(Course.class, code);
            Student s = em.find(Student.class, id);
            Enrollment enrollment = new Enrollment(new EnrollmentPK(code, id), c, s);
            session.save(enrollment);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // TODO: drop a student from a course based on the given parameters, returning true/false depending whether the operation was successful or not
    public boolean dropStudent(String code, int id) {
        try {
            session.beginTransaction();
            EnrollmentPK key = new EnrollmentPK(code, id);
//        Course c = em.find(Course.class, code);
//        Student s = em.find(Student.class, id);
            Enrollment enrollment = em.find(Enrollment.class, key);
            session.delete(enrollment);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // TODO: return a list of all Student entities enrolled in the given course (hint: use the stored procedure 'list_students')
    public List<Student> getStudentsEnrolled(String course) {
        SessionImpl sessionImpl = (SessionImpl) session;
        Connection conn = sessionImpl.connection();
        List<Student> studentEnrolled = new LinkedList<>();
        // Reference: https://www.tutorialspoint.com/how-to-retrieve-multiple-resultsets-from-a-stored-procedure-using-a-jdbc-program
        try {
            CallableStatement callableStatement = conn.prepareCall("{call list_students('"+ course +"')}");
            ResultSet rs = callableStatement.executeQuery();
                while (rs.next()) {
                    Integer stuId = rs.getInt("id");
                    Student student = em.find(Student.class, stuId);
                    studentEnrolled.add(student);
                }
            } catch (SQLException e) {
            e.printStackTrace();
        }
        return studentEnrolled;
    }
}
