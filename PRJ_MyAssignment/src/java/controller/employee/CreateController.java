package controller.employee;

import controller.iam.BaseRequiredAuthorizationController;
import dal.EmployeeDBContext;
import dal.DepartmentDBContext;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import model.Department;
import model.Employee;
import model.iam.User;

@WebServlet("/employee/create")
public class CreateController extends BaseRequiredAuthorizationController {

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String eid = req.getParameter("eid");   // 👈 Lấy ID nhập thủ công
        String ename = req.getParameter("ename");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String did = req.getParameter("did");
        String supervisorId = req.getParameter("supervisorid");

        Employee e = new Employee();

        // Nếu người dùng nhập mã ID → set vào model
        if (eid != null && !eid.trim().isEmpty()) {
            try {
                e.setId(Integer.parseInt(eid.trim()));
            } catch (NumberFormatException ex) {
                // Nếu nhập chữ như E001 → ta có thể xử lý khác, tạm bỏ qua
                // Hoặc bạn có thể thay kiểu id trong model là String nếu mã nhân viên dạng chuỗi
            }
        }

        e.setName(ename);
        e.setEmail(email);
        e.setPhone(phone);

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

        EmployeeDBContext db = new EmployeeDBContext();
        db.insert(e);

        resp.sendRedirect(req.getContextPath() + "/employee/list");
    }

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        DepartmentDBContext ddb = new DepartmentDBContext();
        EmployeeDBContext edb = new EmployeeDBContext();

        ArrayList<Department> divisions = ddb.list();
        ArrayList<Employee> supervisors = edb.list();

        req.setAttribute("divisions", divisions);
        req.setAttribute("supervisors", supervisors);
        req.setAttribute("pageTitle", "Add New Employee");
        req.setAttribute("contentPage", "/view/employee/create.jsp");
        req.getRequestDispatcher("/view/util/layout.jsp").forward(req, resp);
    }
}
