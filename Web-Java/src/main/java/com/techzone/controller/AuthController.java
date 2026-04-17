package com.techzone.controller;

import com.techzone.dao.UserDAO;
import com.techzone.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserDAO userDAO;

    @GetMapping("/login")
    public String getLogin(HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/";
        }
        return "login";
    }

    @PostMapping("/login")
    public String postLogin(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam(required = false) String redirect,
            HttpServletRequest req,
            HttpSession session) {

        User user = userDAO.login(email, password);
        if (user != null) {
            session.setAttribute("currentUser", user);
            if (redirect != null && !redirect.isEmpty()) {
                return "redirect:" + redirect;
            } else if (user.isAdmin()) {
                return "redirect:/admin";
            } else {
                return "redirect:/";
            }
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            req.setAttribute("email", email);
            return "login";
        }
    }

    @GetMapping("/register")
    public String getRegister(HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/";
        }
        return "register";
    }

    @PostMapping("/register")
    public String postRegister(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirm,
            @RequestParam(required = false) String phone,
            HttpServletRequest req,
            HttpSession session) {

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            return "register";
        }
        if (userDAO.emailExists(email)) {
            req.setAttribute("error", "Email này đã được đăng ký!");
            req.setAttribute("name", name);
            return "register";
        }

        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);
        u.setPhone(phone);
        userDAO.register(u);

        // Auto login
        User newUser = userDAO.login(email, password);
        session.setAttribute("currentUser", newUser);
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
