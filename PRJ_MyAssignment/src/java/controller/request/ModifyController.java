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

@WebServlet(urlPatterns = "/request/modifine")
public class ModifyController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int rid = Integer.parseInt(req.getParameter("rid"));
        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        RequestForLeave r = db.get(rid);

        //  Chỉ cho phép người tạo đơn sửa chính đơn của mình, và đơn còn processing
        boolean isOwner = r.getCreated_by().getId() == (user.getEmployee().getId());
        boolean isPending = r.getStatus() == 0;
        boolean notProcessed = (r.getProcessed_by() == null);

        if (!(isOwner && isPending && notProcessed)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "You are not allowed to modify this request.");
            return;
        }
        r.setFrom(Date.valueOf(req.getParameter("from")));
        r.setTo(Date.valueOf(req.getParameter("to")));
        r.setReason(req.getParameter("reason"));
        db.update(r);

        resp.sendRedirect("list");
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int rid = Integer.parseInt(req.getParameter("rid"));
        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        RequestForLeave r = db.get(rid);

        //  Chỉ cho phép người tạo đơn sửa chính đơn của mình, và đơn còn processing
        boolean isOwner = r.getCreated_by().getId() == (user.getEmployee().getId());
        boolean isPending = r.getStatus() == 0;
        boolean notProcessed = (r.getProcessed_by() == null);

        if (!(isOwner && isPending && notProcessed)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "You are not allowed to modify this request.");
            return;
        }

        req.setAttribute("r", r);
        req.getRequestDispatcher("../view/leave/modify.jsp").forward(req, resp);
    }

}
