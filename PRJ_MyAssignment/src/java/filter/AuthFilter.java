package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*") 
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        HttpSession session = request.getSession(false);

        // Chặn truy cập trực tiếp .jsp
        if (uri.endsWith(".jsp")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }


        //  Cho phép request đi tiếp
        chain.doFilter(req, res);
    }

    @Override
    public void init(FilterConfig filterConfig) {}
    @Override
    public void destroy() {}
}
