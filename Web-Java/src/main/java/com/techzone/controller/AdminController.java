package com.techzone.controller;

import com.techzone.dao.OrderDAO;
import com.techzone.dao.ProductDAO;
import com.techzone.dao.UserDAO;
import com.techzone.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private UserDAO userDAO;

    @GetMapping
    public String getAdmin(
            @RequestParam(required = false, defaultValue = "dashboard") String tab,
            Model model) {

        model.addAttribute("tab", tab);
        model.addAttribute("totalProducts", productDAO.count());
        model.addAttribute("totalOrders", orderDAO.count());
        model.addAttribute("totalUsers", userDAO.count());

        // Heavy stats only needed on dashboard
        if ("dashboard".equals(tab)) {
            model.addAttribute("totalRevenue", orderDAO.totalRevenue());
            model.addAttribute("revenueThisMonth", orderDAO.revenueThisMonth());
            model.addAttribute("revenueLastMonth", orderDAO.revenueLastMonth());
            model.addAttribute("ordersThisMonth", orderDAO.ordersThisMonth());
            model.addAttribute("topProducts", orderDAO.getTopSellingProducts());
        }

        switch (tab) {
            case "products":
                model.addAttribute("products", productDAO.getAll());
                break;
            case "orders":
                model.addAttribute("orders", orderDAO.getAll());
                break;
            case "users":
                model.addAttribute("users", userDAO.getAll());
                break;
        }

        return "admin";
    }

    @PostMapping
    public String postAdmin(
            @RequestParam(required = false, defaultValue = "") String action,
            HttpServletRequest req) {

        String redirectTab = "dashboard";

        switch (action) {
            case "addProduct": {
                Product p = buildProduct(req);
                productDAO.insert(p);
                redirectTab = "products";
                break;
            }
            case "editProduct": {
                Product p = buildProduct(req);
                p.setId(Integer.parseInt(req.getParameter("id")));
                productDAO.update(p);
                redirectTab = "products";
                break;
            }
            case "deleteProduct": {
                productDAO.delete(Integer.parseInt(req.getParameter("id")));
                redirectTab = "products";
                break;
            }
            case "updateOrderStatus": {
                orderDAO.updateStatus(
                        Integer.parseInt(req.getParameter("id")),
                        req.getParameter("status"));
                redirectTab = "orders";
                break;
            }
            case "deleteUser": {
                userDAO.delete(Integer.parseInt(req.getParameter("id")));
                redirectTab = "users";
                break;
            }
        }

        return "redirect:/admin?tab=" + redirectTab;
    }

    private Product buildProduct(HttpServletRequest req) {
        Product p = new Product();
        p.setName(req.getParameter("name"));
        p.setCategory(req.getParameter("category"));
        p.setBrand(req.getParameter("brand"));
        String priceStr = req.getParameter("price").replace(".", "").replace(",", "");
        p.setPrice(Long.parseLong(priceStr));
        String oldP = req.getParameter("oldPrice");
        if (oldP != null && !oldP.isBlank()) {
            p.setOldPrice(Long.parseLong(oldP.replace(".", "").replace(",", "")));
        }
        p.setDescription(req.getParameter("description"));
        p.setSpecs(req.getParameter("specs"));
        p.setEmoji(req.getParameter("emoji"));
        p.setBadge(req.getParameter("badge"));
        String stockStr = req.getParameter("stock");
        p.setStock(stockStr != null && !stockStr.isBlank() ? Integer.parseInt(stockStr) : 0);
        return p;
    }
}
