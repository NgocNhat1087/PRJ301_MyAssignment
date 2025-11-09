/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.employee;

import controller.iam.BaseRequiredAuthorizationController;
import dal.EmployeeDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Employee;
import model.iam.User;

@WebServlet(urlPatterns = "/employee/remove")
public class DeleteController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        try {
            String id_raw = req.getParameter("id");
            if (id_raw != null && !id_raw.isEmpty()) {
                int id = Integer.parseInt(id_raw);
                Employee e = new Employee();
                e.setId(id);
                EmployeeDBContext db = new EmployeeDBContext();
                db.delete(e);

                resp.sendRedirect(req.getContextPath() + "/employee/list");
            } else {
                resp.sendRedirect(req.getContextPath() + "/employee/list?error=missing_id");
            }
        } catch (NumberFormatException e) {
            Logger.getLogger(DeleteController.class.getName()).log(Level.SEVERE, null, e);
            resp.sendRedirect(req.getContextPath() + "/employee/list?error=invalid_id");
        }
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        // Cho phép xóa qua GET (nếu bạn dùng link kiểu /employee/remove?id=3)
        processPost(req, resp, user);
    }
}
