package controller.employee;

import controller.iam.BaseRequiredAuthorizationController;
import dal.EmployeeDBContext;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import model.Employee;
import model.iam.User;

@WebServlet("/employee/list")
public class ListController extends BaseRequiredAuthorizationController {

   
    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        processGet(req,resp, user); 

    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
          EmployeeDBContext db = new EmployeeDBContext();
        ArrayList<Employee> employees = db.list();

        req.setAttribute("employees", employees);
        req.setAttribute("pageTitle", "Employee Management");
        req.setAttribute("contentPage", "/view/employee/list.jsp");
        req.getRequestDispatcher("/view/util/layout.jsp").forward(req, resp);
    }
}
