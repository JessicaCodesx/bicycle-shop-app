package com.jessica.bicycleshopapp.filter;

import com.jessica.bicycleshopapp.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class AuthFilter implements Filter {
    private final Map<String, List<String>> protectedPages = new HashMap<>();

    @Override
    public void init(FilterConfig filterConfig) {
        protectedPages.put("admin", List.of("user-report.jsp"));
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        if (uri.endsWith("login.jsp") || uri.endsWith("login") ||
                uri.contains("css") || uri.contains("js") || uri.contains("images") || uri.endsWith(".ico")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String role = user.getRole().toLowerCase();

        for (Map.Entry<String, List<String>> entry : protectedPages.entrySet()) {
            String restrictedRole = entry.getKey();
            List<String> pages = entry.getValue();

            for (String page : pages) {
                if (uri.contains(page) && !role.equals(restrictedRole)) {
                    resp.getWriter().write("Access Denied");
                    return;
                }
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}