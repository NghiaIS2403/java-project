package com.techzone.interceptor;

import com.techzone.model.User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        User user = (User) request.getSession().getAttribute("currentUser");
        String uri = request.getRequestURI();

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + uri);
            return false;
        }

        if (uri.startsWith(request.getContextPath() + "/admin") && !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }

        return true;
    }
}
