package com.techzone.controller;

import com.techzone.dao.OrderDAO;
import com.techzone.model.Order;
import com.techzone.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderDAO orderDAO;

    @GetMapping
    public String getOrders(
            @RequestParam(required = false) String success,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("currentUser");
        List<Order> orders = orderDAO.getByUserId(user.getId());
        for (Order o : orders) {
            o.setItems(orderDAO.getItemsByOrderId(o.getId()));
        }
        model.addAttribute("orders", orders);
        model.addAttribute("successOrderId", success);
        return "orders";
    }
}
