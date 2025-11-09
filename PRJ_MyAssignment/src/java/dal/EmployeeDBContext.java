/*
 * EmployeeDBContext - Chuẩn hóa theo ERD
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Department;
import model.Employee;

public class EmployeeDBContext extends DBContext<Employee> {

    @Override
    public ArrayList<Employee> list() {
        ArrayList<Employee> employees = new ArrayList<>();
        try {
            String sql = """
                SELECT e.eid, e.ename, e.did, e.supervisorid, e.email, e.phone,
                       d.dname,
                       s.ename AS supervisor_name
                FROM Employee e
                LEFT JOIN Division d ON e.did = d.did
                LEFT JOIN Employee s ON e.supervisorid = s.eid
                ORDER BY e.eid
            """;

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));
                e.setEmail(rs.getString("email"));
                e.setPhone(rs.getString("phone"));

                // Division
                int did = rs.getInt("did");
                if (!rs.wasNull()) {
                    Department d = new Department();
                    d.setId(did);
                    d.setName(rs.getString("dname"));
                    e.setDept(d);
                }

                // Supervisor
                int supId = rs.getInt("supervisorid");
                if (!rs.wasNull()) {
                    Employee sup = new Employee();
                    sup.setId(supId);
                    sup.setName(rs.getString("supervisor_name"));
                    e.setSupervisor(sup);
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
            String sql = """
                SELECT e.eid, e.ename, e.did, e.supervisorid, e.email, e.phone,
                       d.dname,
                       s.ename AS supervisor_name
                FROM Employee e
                LEFT JOIN Division d ON e.did = d.did
                LEFT JOIN Employee s ON e.supervisorid = s.eid
                WHERE e.eid = ?
            """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));
                e.setEmail(rs.getString("email"));
                e.setPhone(rs.getString("phone"));

                // Division
                int did = rs.getInt("did");
                if (!rs.wasNull()) {
                    Department d = new Department();
                    d.setId(did);
                    d.setName(rs.getString("dname"));
                    e.setDept(d);
                }

                // Supervisor
                int supId = rs.getInt("supervisorid");
                if (!rs.wasNull()) {
                    Employee sup = new Employee();
                    sup.setId(supId);
                    sup.setName(rs.getString("supervisor_name"));
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
        String sql;
        boolean hasManualId = model.getId() > 0;

        if (hasManualId) {
            sql = """
                INSERT INTO Employee (eid, ename, did, supervisorid, email, phone)
                VALUES (?, ?, ?, ?, ?, ?)
            """;
        } else {
            sql = """
                INSERT INTO Employee (ename, did, supervisorid, email, phone)
                VALUES (?, ?, ?, ?, ?)
            """;
        }

        PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        int paramIndex = 1;

        // Nếu có ID thủ công, set trước
        if (hasManualId) {
            stm.setInt(paramIndex++, model.getId());
        }

        stm.setString(paramIndex++, model.getName());

        if (model.getDept() != null) {
            stm.setInt(paramIndex++, model.getDept().getId());
        } else {
            stm.setNull(paramIndex++, Types.INTEGER);
        }

        if (model.getSupervisor() != null) {
            stm.setInt(paramIndex++, model.getSupervisor().getId());
        } else {
            stm.setNull(paramIndex++, Types.INTEGER);
        }

        stm.setString(paramIndex++, model.getEmail());
        stm.setString(paramIndex++, model.getPhone());

        stm.executeUpdate();

        // Nếu không nhập ID thủ công → lấy ID tự sinh
        if (!hasManualId) {
            try (ResultSet rs = stm.getGeneratedKeys()) {
                if (rs.next()) {
                    model.setId(rs.getInt(1));
                }
            }
        }

    } catch (SQLException ex) {
        Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        closeConnection();
    }
}


    @Override
    public void update(Employee model) {
    String sql = """
        UPDATE Employee
        SET ename = ?, did = ?, supervisorid = ?, email = ?, phone = ?
        WHERE eid = ?
    """;

    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        int index = 1;

        // Name
        stm.setString(index++, model.getName());

        // Department
        if (model.getDept() != null) {
            stm.setInt(index++, model.getDept().getId());
        } else {
            stm.setNull(index++, Types.INTEGER);
        }

        // Supervisor
        if (model.getSupervisor() != null) {
            stm.setInt(index++, model.getSupervisor().getId());
        } else {
            stm.setNull(index++, Types.INTEGER);
        }

        // Email & Phone
        stm.setString(index++, model.getEmail());
        stm.setString(index++, model.getPhone());

        // Employee ID (primary key)
        stm.setInt(index++, model.getId());

        // Thực thi
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
            String sql = "DELETE FROM Employee WHERE eid = ?";
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
