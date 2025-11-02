/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dal;

import java.util.ArrayList;
import model.Employee;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;


public class EmployeeDBContext extends DBContext<Employee>{

    @Override
    public ArrayList<Employee> list() {
        ArrayList<Employee> employees = new ArrayList<>();
        try {
            String sql = """
                SELECT e.eid, e.ename, e.supervisorid
                FROM Employee e
            """;
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));

                int supervisorId = rs.getInt("supervisorid");
                if (!rs.wasNull()) {
                    Employee supervisor = new Employee();
                    supervisor.setId(supervisorId);
                    e.setSupervisor(supervisor);
                }

                employees.add(e);
            }

        } catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }

        return employees;
    }

    @Override
    public Employee get(int id) {
        Employee e = null;
        try {
            String sql = "SELECT eid, ename, supervisorid FROM Employee WHERE eid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));
                int supId = rs.getInt("supervisorid");
                if (!rs.wasNull()) {
                    Employee sup = new Employee();
                    sup.setId(supId);
                    e.setSupervisor(sup);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
        return e;
    }

    @Override
    public void insert(Employee model) {
        try {
            String sql = """
                         INSERT INTO Employee (ename, supervisorid)
                         VALUES (?, ?)
                         """;
            PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setString(1, model.getName());
            if (model.getSupervisor() != null) {
                stm.setInt(2, model.getSupervisor().getId());
            } else {
                stm.setNull(2, Types.INTEGER);
            }
            stm.executeUpdate();

            // Lấy ID tự sinh
            ResultSet rs = stm.getGeneratedKeys();
            if (rs.next()) {
                model.setId(rs.getInt(1));
            }

        } catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
    }

    @Override
    public void update(Employee model) {
        try {
            String sql = """
                         UPDATE Employee
                         SET ename = ?, supervisorid = ?
                         WHERE eid = ?
                         """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, model.getName());
            if (model.getSupervisor() != null) {
                stm.setInt(2, model.getSupervisor().getId());
            } else {
                stm.setNull(2, Types.INTEGER);
            }
            stm.setInt(3, model.getId());
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
    }

    @Override
    public void delete(Employee model) {
        try {
            String sql = """
                         DELETE FROM Employee
                         WHERE eid = ?
                         """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
    }

}
