package model.repository.impl;

import model.bean.Student;
import model.repository.IStudentRepository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class StudentRepository implements IStudentRepository {

    List<Student> studentList = new ArrayList<>();

    private dao.BaseRepository baseRepository = new dao.BaseRepository();

    @Override
    public List<Student> findAll() {
        List<Student> studentList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = this.baseRepository.getConnection().prepareStatement(
                    "select studentId,studentName,phone\n" +
                            "from student");
            ResultSet resultSet = preparedStatement.executeQuery();
            Student student = null;
            while (resultSet.next()) {
                student = new Student();
                student.setStudentId(resultSet.getInt("studentid"));
                student.setStudentName(resultSet.getString("studentname"));
                student.setPhone(resultSet.getString("phone"));
                studentList.add(student);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return studentList;
    }

    @Override
    public Student findById(Integer id) {
        Student student = null;
        try {
            PreparedStatement preparedStatement = this.baseRepository.
                    getConnection().prepareStatement("select studentId,studentName,Phone\n" +
                    "from student\n" +
                    "where  studentId=?");
            preparedStatement.setString(1, id + "");
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                student = new Student();
                student.setStudentId(id);
                student.setStudentName(resultSet.getString("studentname"));
                student.setPhone(resultSet.getString("phone"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return student;
    }

    @Override
    public String save(Student student) {
        int row=0;

        try {
            PreparedStatement preparedStatement = this.baseRepository.
                    getConnection().prepareStatement("update student\n" +
                    "set studentName=?,Phone=?\n" +
                    "where  studentId=?");

            preparedStatement.setString(1, student.getStudentName());
            preparedStatement.setString(2, student.getPhone());
            preparedStatement.setString(3,student.getStudentId()+"");

//            n???y c??u l???nh select th?? ta d??ng query th?? nh???ng c??u l???nh thu???c v???
//            update hay insert,delete  (nh??ng c??u l???nh l??m ???nh h?????ng d??? li???u trong DB) ta
//            d??ng chung 1 th???ng l?? update th??i
         row=preparedStatement.executeUpdate();



        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


        return row>0 ? "thanh cong":"fail";
    }
}
