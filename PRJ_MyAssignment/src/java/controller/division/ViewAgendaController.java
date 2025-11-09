/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.division;

import controller.iam.BaseRequiredAuthorizationController;
import dal.EmployeeDBContext;
import dal.RequestForLeaveDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import model.Employee;
import model.RequestForLeave;

import model.iam.User;

/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/division/agenda")
public class ViewAgendaController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {

        String from_raw = req.getParameter("from");
        String to_raw = req.getParameter("to");

        // Nếu chưa chọn thì dùng mặc định
        Date from = (from_raw == null || from_raw.isEmpty())
                ? Date.valueOf("2025-11-3")
                : Date.valueOf(from_raw);
        Date to = (to_raw == null || to_raw.isEmpty())
                ? Date.valueOf("2025-11-9")
                : Date.valueOf(to_raw);

        EmployeeDBContext dbEmp = new EmployeeDBContext();
        RequestForLeaveDBContext dbReq = new RequestForLeaveDBContext();

        ArrayList<Employee> employees = dbEmp.list();
        HashMap<Integer, ArrayList<RequestForLeave>> map = dbReq.getRequestsInRange(from, to);

        req.setAttribute("from", from);
        req.setAttribute("to", to);
        req.setAttribute("employees", employees);
        req.setAttribute("map", map);
        req.setAttribute("pageTitle", "Division Agenda");
        req.setAttribute("contentPage", "../division/agenda.jsp");
        req.getRequestDispatcher("/view/util/layout.jsp").forward(req, resp);

        //req.getRequestDispatcher("../view/division/agenda.jsp").forward(req, resp);
    }

}
