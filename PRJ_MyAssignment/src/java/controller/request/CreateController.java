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
import model.RequestForLeave;
import model.iam.User;
import java.sql.Date;
/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/request/create")
public class CreateController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        RequestForLeave rfl = new RequestForLeave();
        rfl.setFrom(Date.valueOf(req.getParameter("from")));
        rfl.setTo(Date.valueOf(req.getParameter("to")));
        rfl.setReason(req.getParameter("reason"));
        rfl.setCreated_by(user.getEmployee());
        
        db.insert(rfl);
        req.setAttribute("msg", "Create Success");
        req.getRequestDispatcher("../view/request/create.jsp").forward(req, resp);
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        req.getRequestDispatcher("../view/request/create.jsp").forward(req, resp);
    }
    
}
