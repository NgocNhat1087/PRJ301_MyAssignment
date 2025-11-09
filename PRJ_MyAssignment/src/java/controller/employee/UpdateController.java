/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package controller.employee;

import controller.iam.BaseRequiredAuthorizationController;
import dal.DepartmentDBContext;
import dal.EmployeeDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Department;
import model.Employee;
import model.iam.User;

@WebServlet(urlPatterns = "/employee/edit")

public class UpdateController extends BaseRequiredAuthorizationController {
    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        EmployeeDBContext edb = new EmployeeDBContext();
        DepartmentDBContext ddb = new DepartmentDBContext();

        Employee employee = edb.get(id);
        ArrayList<Department> divisions = ddb.list();
        ArrayList<Employee> supervisors = edb.list();

        req.setAttribute("employee", employee);
        req.setAttribute("divisions", divisions);
        req.setAttribute("supervisors", supervisors);
        req.setAttribute("pageTitle", "Edit Employee");
        req.setAttribute("contentPage", "/view/employee/edit.jsp");
        req.getRequestDispatcher("/view/util/layout.jsp").forward(req, resp);
    }

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Employee e = new Employee();
        e.setId(Integer.parseInt(req.getParameter("eid")));
        e.setName(req.getParameter("ename"));
        e.setEmail(req.getParameter("email"));
        e.setPhone(req.getParameter("phone"));

        String did = req.getParameter("did");
        String supervisorId = req.getParameter("supervisorid");

        if (did != null && !did.isEmpty()) {
            Department d = new Department();
            d.setId(Integer.parseInt(did));
            e.setDept(d);
        }

        if (supervisorId != null && !supervisorId.isEmpty()) {
            Employee sup = new Employee();
            sup.setId(Integer.parseInt(supervisorId));
            e.setSupervisor(sup);
        }

        new EmployeeDBContext().update(e);
        resp.sendRedirect(req.getContextPath() + "/employee/list");
    }
}
