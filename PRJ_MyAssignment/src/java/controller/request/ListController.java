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
import java.util.ArrayList;
import model.RequestForLeave;
import model.iam.User;

/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/request/list")
public class ListController extends BaseRequiredAuthorizationController {

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {

        int eid = user.getEmployee().getId();

        int pagesize = 10; // số đơn mỗi trang
        String page = req.getParameter("page");
        page = (page == null) ? "1" : page;
        int pageindex = Integer.parseInt(page);

        RequestForLeaveDBContext db = new RequestForLeaveDBContext();
        ArrayList<RequestForLeave> rfls = db.list(eid, pageindex, pagesize);
        db = new RequestForLeaveDBContext();
        int totalRecords = db.count(eid);
        int totalPages = (totalRecords % pagesize == 0) ? totalRecords / pagesize : totalRecords / pagesize + 1;

        req.setAttribute("rfls", rfls);
        req.setAttribute("pageindex", pageindex);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("action", "list");
        req.setAttribute("method", "GET");
        req.setAttribute("pageTitle", "Request List");
        req.setAttribute("contentPage", "../request/list.jsp");
        req.getRequestDispatcher("/view/util/layout.jsp").forward(req, resp);

//        req.getRequestDispatcher("../view/request/list.jsp").forward(req, resp);
    }

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        processRequest(req, resp, user);
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        processRequest(req, resp, user);
    }
}
