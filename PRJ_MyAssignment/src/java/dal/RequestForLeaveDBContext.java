/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.RequestForLeave;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Department;
import model.Employee;

public class RequestForLeaveDBContext extends DBContext<RequestForLeave> {

    public ArrayList<RequestForLeave> getByEmployeeAndSubodiaries(int eid) {
        ArrayList<RequestForLeave> rfls = new ArrayList<>();
        try {

            String sql = """
                                 WITH Org AS (
                                 \t-- get current employee - eid = @eid
                                 \tSELECT *, 0 as lvl FROM Employee e WHERE e.eid = ?
                                 \t
                                 \tUNION ALL
                                 \t-- expand to other subodinaries
                                 \tSELECT c.*,o.lvl + 1 as lvl FROM Employee c JOIN Org o ON c.supervisorid = o.eid
                                 )
                                 SELECT
                                 \t\t[rid]
                                 \t  ,[created_by]
                                 \t  ,e.ename as [created_name]
                                       ,[created_time]
                                       ,[from]
                                       ,[to]
                                       ,[reason]
                                       ,[status]
                                       ,[processed_by]
                                 \t  ,p.ename as [processed_name]
                                 FROM Org e INNER JOIN [RequestForLeave] r ON e.eid = r.created_by
                                 \t\t\tLEFT JOIN Employee p ON p.eid = r.processed_by""";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, eid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RequestForLeave rfl = new RequestForLeave();

                Employee created_by = new Employee();
                created_by.setId(rs.getInt("created_by"));
                created_by.setName(rs.getString("created_name"));
                rfl.setCreated_by(created_by);

                rfl.setId(rs.getInt("rid"));
                rfl.setCreated_time(rs.getTimestamp("created_time"));
                rfl.setFrom(rs.getDate("from"));
                rfl.setTo(rs.getDate("to"));
                rfl.setReason(rs.getString("reason"));
                rfl.setStatus(rs.getInt("status"));

                int processed_by_id = rs.getInt("processed_by");
                if (processed_by_id != 0) {
                    Employee processed_by = new Employee();
                    processed_by.setId(rs.getInt("processed_by"));
                    processed_by.setName(rs.getString("processed_name"));
                    rfl.setProcessed_by(processed_by);
                }
                rfls.add(rfl);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RequestForLeaveDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
        return rfls;

    }

    @Override
    public ArrayList<RequestForLeave> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public RequestForLeave get(int id) {
        try {
            String sql = """
                         SELECT [rid]
                               ,[created_by]
                               ,e.ename AS [created_name]
                               ,[created_time]
                               ,[from]
                               ,[to]
                               ,[reason]
                               ,[status]
                               ,[processed_by]
                           FROM [RequestForLeave] r
                           JOIN [Employee] e ON r.created_by = e.eid
                           WHERE [rid] = ?""";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                RequestForLeave rfl = new RequestForLeave();
                Employee created_by = new Employee();
                created_by.setId(rs.getInt("created_by"));
                created_by.setName(rs.getString("created_name"));
                rfl.setCreated_by(created_by);

                rfl.setId(rs.getInt("rid"));
                rfl.setFrom(rs.getDate("from"));

                rfl.setTo(rs.getDate("to"));
                rfl.setReason(rs.getString("reason"));
                rfl.setStatus(rs.getInt("status"));
                Employee e = new Employee();
                e.setId(rs.getInt("processed_by"));

                rfl.setProcessed_by(e);

                return rfl;
            }

        } catch (SQLException ex) {
            Logger.getLogger(RequestForLeaveDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }
        return null;
    }

    @Override
    public void insert(RequestForLeave model) {

        try {
            //begin transaction
            connection.setAutoCommit(false);
            //insert employee
            String sql_insert_request = """
                                        INSERT INTO [RequestForLeave]
                                                   ([created_by]
                                                   ,[created_time]
                                                   ,[from]
                                                   ,[to]
                                                   ,[reason]
                                                   ,[status]
                                                   )
                                             VALUES
                                                   (?
                                                   ,?
                                                   ,?
                                                   ,?
                                                   ,?
                                                   ,0)
                                                 """;

            PreparedStatement stm = connection.prepareStatement(sql_insert_request);
            stm.setInt(1, model.getCreated_by().getId());
            model.setCreated_time(new java.util.Date());
            stm.setTimestamp(2, new java.sql.Timestamp(model.getCreated_time().getTime()));
            stm.setDate(3, model.getFrom());
            stm.setDate(4, model.getTo());
            stm.setString(5, model.getReason());
            stm.executeUpdate();

            //get eid
            String sql_select_rid = "SELECT SCOPE_IDENTITY() as rid";
            PreparedStatement stm_select_rid = connection.prepareStatement(sql_select_rid);
            ResultSet rs = stm_select_rid.executeQuery();
            if (rs.next()) {
                model.setId(rs.getInt("rid"));
            }
            //commit transaction
            connection.commit();
        } catch (SQLException ex) {
            try {
                //rollback transaction
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(RequestForLeaveDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(RequestForLeaveDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(RequestForLeaveDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            closeConnection();
        }

    }

    public void updateStatus(RequestForLeave model) {
        try {
            String sql = """
                         UPDATE [RequestForLeave]
                            SET 
                               [status] = ?
                               ,[processed_by] = ?
                          WHERE rid = ?""";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getStatus());
            
            
            stm.setInt(2, model.getProcessed_by().getId());
            
            stm.setInt(3, model.getId());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RequestForLeaveDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection();
        }

    }

    @Override
    public void update(RequestForLeave model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(RequestForLeave model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
