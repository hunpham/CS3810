/*
 * CS3810 - Principles of Database Systems - Spring 2021
 * Instructor: Thyago Mota
 * Description: DB 03 - EnrollmentPK
 * Student(s) Name(s): Hung Pham
 */

import javax.persistence.*;
import java.io.Serializable;

@Embeddable
public class EnrollmentPK implements Serializable {

    @Column(name = "code")
    private String code;

    @Column(name = "id")
    private int id;

    public EnrollmentPK() {
    }

    public EnrollmentPK(String code, int id) {
        this.code = code;
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
