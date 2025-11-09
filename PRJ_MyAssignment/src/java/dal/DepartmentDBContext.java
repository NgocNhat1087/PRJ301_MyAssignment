package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Department;

public class DepartmentDBContext extends DBContext<Department> {

    @Override
    public ArrayList<Department> list() {
        ArrayList<Department> list = new ArrayList<>();
        try {
            String sql = """
                SELECT did, dname
                FROM Division
                ORDER BY did
            """;
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Department d = new Department();
                d.setId(rs.getInt("did"));
                d.setName(rs.getString("dname"));
                list.add(d);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DepartmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
        return list;
    }

    @Override
    public Department get(int id) {
        Department d = null;
        try {
            String sql = """
                SELECT did, dname
                FROM Division
                WHERE did = ?
            """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                d = new Department();
                d.setId(rs.getInt("did"));
                d.setName(rs.getString("dname"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(DepartmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
        return d;
    }

    @Override
    public void insert(Department model) {
        try {
            String sql = """
                INSERT INTO Division (dname)
                VALUES (?)
            """;
            PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setString(1, model.getName());
            stm.executeUpdate();

            ResultSet rs = stm.getGeneratedKeys();
            if (rs.next()) {
                model.setId(rs.getInt(1));
            }

        } catch (SQLException ex) {
            Logger.getLogger(DepartmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
    }

    @Override
    public void update(Department model) {
        try {
            String sql = """
                UPDATE Division
                SET dname = ?
                WHERE did = ?
            """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, model.getName());
            stm.setInt(2, model.getId());
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DepartmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
    }

    @Override
    public void delete(Department model) {
        try {
            String sql = "DELETE FROM Division WHERE did = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getId());
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DepartmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
    }
}
