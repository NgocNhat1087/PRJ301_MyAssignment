/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.request;

import controller.iam.BaseRequiredAuthorizationController;
import dal.RequestForLeaveDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Employee;
import model.RequestForLeave;
import model.iam.User;

/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/request/review")
public class ReviewController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        RequestForLeave rfl = new RequestForLeave();
        int rid = Integer.parseInt(req.getParameter("rid"));
        String action = req.getParameter("action");
        int status = 0;
        Employee reviewer = user.getEmployee();
        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        if (action.equals("approve")) {
            status = 1;
            
        } else if (action.equals("reject")) {
            status = 2;
        }
        rfl.setId(rid);
        rfl.setStatus(status);
        rfl.setProcessed_by(reviewer);
        db.updateStatus(rfl);
        resp.sendRedirect("list"); // quay lại trang danh sách
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        RequestForLeave rfl = db.get(id);
        
        req.setAttribute("rfl", rfl);
        req.getRequestDispatcher("../view/request/review.jsp").forward(req, resp);
    }
    
}
