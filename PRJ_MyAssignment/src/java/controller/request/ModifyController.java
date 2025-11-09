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
import java.sql.Date;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/modify")
public class ModifyController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        RequestForLeave r = new RequestForLeave();


        r.setFrom(Date.valueOf(req.getParameter("from")));
        r.setTo(Date.valueOf(req.getParameter("to")));
        r.setReason(req.getParameter("reason"));
        r.setId(id);

        db.update(r);

        resp.sendRedirect("list");
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        RequestForLeave r = db.get(id);

      
        req.setAttribute("r", r);
        req.setAttribute("pageTitle", "Modify Request");
        req.setAttribute("contentPage", "../request/modify.jsp");
        req.getRequestDispatcher("/view/util/layout.jsp").forward(req, resp);

       
    }

}
