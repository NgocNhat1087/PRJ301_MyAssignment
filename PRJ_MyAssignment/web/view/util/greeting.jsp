<%-- 
    Document   : greeting
    Created on : Oct 18, 2025, 11:10:55 AM
    Author     : sonnt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        

        <div class="greeting-box text-center mx-auto p-2 rounded-3 mb-4">
            <c:if test="${sessionScope.auth ne null}">
                <h6 class="fw-semibold mb-1">
                    <i class="bi bi-person-circle me-1 text-accent"></i>
                    Hello, <span class="text-accent">${sessionScope.auth.displayname}</span>
                </h6>
                <small class="text-subtle">
                    ID: ${sessionScope.auth.employee.id} — ${sessionScope.auth.employee.name}
                </small>
            </c:if>

            <c:if test="${sessionScope.auth eq null}">
                <small class="text-muted">
                    <i class="bi bi-exclamation-triangle text-warning"></i>
                    You are not logged in yet.
                </small>
            </c:if>
        </div>

        <style>
            .greeting-box {
                max-width: 420px; /* ✅ Thu nhỏ khung */
                background: var(--bg-card, rgba(255,255,255,0.85));
                backdrop-filter: blur(10px);
                border: 1px solid rgba(0,0,0,0.05);
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
                color: var(--text-main, #2c2c2c);
                transition: 0.3s ease;
            }

            .text-accent {
                color: var(--accent, #0d6efd);
            }

            .text-subtle {
                color: var(--text-sub, #666);
            }

            /* === Dark theme support === */
            [data-theme="dark"] .greeting-box {
                background: rgba(40, 41, 45, 0.8);
                border: 1px solid rgba(255,255,255,0.08);
                box-shadow: 0 2px 10px rgba(0,0,0,0.5);
                color: #e5e7eb;
            }

            [data-theme="dark"] .text-accent {
                color: #60a5fa;
            }

            [data-theme="dark"] .text-subtle {
                color: #9ca3af;
            }
        </style>

    </body>
</html>
