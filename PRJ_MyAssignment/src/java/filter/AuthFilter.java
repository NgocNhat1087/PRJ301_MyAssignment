package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*") // áp dụng cho tất cả request
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        HttpSession session = request.getSession(false);

        // ️⃣ Chặn truy cập trực tiếp .jsp
        if (uri.endsWith(".jsp")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2️⃣ Kiểm tra đăng nhập (ví dụ ẩn URL home)
        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        boolean isLoginRequest = uri.endsWith("/login") || uri.endsWith("/login.jsp");

        if (!loggedIn && !isLoginRequest) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 3️⃣ Cho phép request đi tiếp
        chain.doFilter(req, res);
    }

    @Override
    public void init(FilterConfig filterConfig) {}
    @Override
    public void destroy() {}
}
