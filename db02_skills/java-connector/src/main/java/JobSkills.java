/*
 * CS3810 - Principles of Database Systems - Spring 2021
 * Instructor: Thyago Mota
 * Description: DB 02 - JobSkills
 * Student(s) Name(s): Hung Pham
 */

import java.io.*;
import java.sql.*;
import java.util.*;

public class JobSkills {

    public static String DATASET = "data/job_skills.csv";

    public static void main(String[] args) throws IOException, SQLException {

        // TODO: load database properties
        Properties prop = new Properties();
        prop.load(new FileInputStream("config.properties"));

        String server = prop.getProperty("server");
        String database = prop.getProperty("database");
        String user = prop.getProperty("user");
        String password = prop.getProperty("password");
        String connectURL = "jdbc:mysql://" + server + "/" + database + "?serverTimezone=UTC&user=" + user + "&password=" + password;

        // TODO: connect to the database
        Connection conn = DriverManager.getConnection(connectURL);
        System.out.println("Successfully connected to MySQL database: " + database);

        // TODO: complete the data load
        // References: https://www.codejava.net/coding/java-code-example-to-insert-data-from-csv-to-database
        int batchSize = 20;
        System.out.println("Populating Tables...");
        try {
            String sql = "INSERT IGNORE INTO Positions (posID, position) VALUES (?, ?)";
            PreparedStatement sm = conn.prepareStatement(sql);

            String sql2 = "INSERT IGNORE INTO SkillsDesc (skillId, skill) VALUES (?, ?)";
            PreparedStatement sm2 = conn.prepareStatement(sql2);

            String sql3 = "INSERT INTO PosSkills (posId, skillId) VALUES (?, ?)";
            PreparedStatement sm3 = conn.prepareStatement(sql3);

            BufferedReader lineReader = new BufferedReader(new FileReader(DATASET));
            String lineText = null;

            int count = 0;

            while ((lineText = lineReader.readLine()) != null) {
                String[] data = lineText.split(",");
                String[] data1 = data[0].split(":", 2);
                String posID = data1[0];
                String position = data1[1];

                Integer iPosId = Integer.parseInt(posID);
                sm.setInt(1, iPosId);
                sm.setString(2, position);


                String[] data2 = data[1].split(";");
                for (int i = 0; i != data2.length; i++) {
                    String tmp = data2[i];
                    String[] data3 = tmp.split(":", 2);
                    String skillId = data3[0];
                    String skill = data3[1];

                    Integer iSkillId = Integer.parseInt(skillId);
                    sm2.setInt(1, iSkillId);
                    sm2.setString(2, skill);
                    sm3.setInt(1, iPosId);
                    sm3.setInt(2, iSkillId);

                    sm2.addBatch();
                    sm3.addBatch();
                    if (count % batchSize == 0) {
                        sm2.executeBatch();
                        sm3.executeBatch();
                    }
                }

                sm.addBatch();

                if (count % batchSize == 0) {
                    sm.executeBatch();
                }
            }

            lineReader.close();

            // execute the remaining queries
            sm.executeBatch();
            sm2.executeBatch();
            sm3.executeBatch();
            System.out.println("Tables populated.");

        } catch (IOException ex) {
            System.err.println(ex);
        } catch (SQLException ex) {
            ex.printStackTrace();

            try {
                conn.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


}
