/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.department;

import controller.iam.BaseRequiredAuthorizationController;
import dal.DepartmentDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Department;
import model.iam.User;

@WebServlet(urlPatterns = "/department/list")
public class ListController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        DepartmentDBContext db = new DepartmentDBContext();
        ArrayList<Department> list = db.list();

        req.setAttribute("departments", list);
        req.setAttribute("pageTitle", "Department List");
        req.setAttribute("contentPage", "../department/list.jsp");
        req.getRequestDispatcher("/view/util/layout.jsp").forward(req, resp);
    }

}
