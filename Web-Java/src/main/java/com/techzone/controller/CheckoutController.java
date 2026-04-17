package com.techzone.controller;

import com.techzone.dao.OrderDAO;
import com.techzone.dao.ProductDAO;
import com.techzone.model.CartItem;
import com.techzone.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {

    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private ProductDAO productDAO;

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        return cart != null ? cart : new ArrayList<>();
    }

    private void enrichCart(List<CartItem> cart) {
        for (CartItem item : cart) {
            if (item.getProduct() == null) {
                try {
                    item.setProduct(productDAO.getById(item.getProductId()));
                } catch (Exception ignored) {
                }
            }
        }
    }

    @GetMapping
    public String getCheckout(HttpSession session, Model model) {
        List<CartItem> cart = getCart(session);
        if (cart.isEmpty()) {
            return "redirect:/cart";
        }
        enrichCart(cart);
        model.addAttribute("cart", cart);
        model.addAttribute("total", cart.stream().mapToLong(CartItem::getSubtotal).sum());
        return "checkout";
    }

    @PostMapping
    public String postCheckout(
            @RequestParam(required = false) String fullName,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String address,
            @RequestParam(required = false) String note,
            HttpServletRequest req,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("currentUser");
        List<CartItem> cart = getCart(session);

        if (cart.isEmpty()) {
            return "redirect:/cart";
        }
        enrichCart(cart);

        if (fullName == null || fullName.isBlank() || phone == null || phone.isBlank() || address == null
                || address.isBlank()) {
            model.addAttribute("error", "Vui lòng điền đầy đủ thông tin giao hàng!");
            model.addAttribute("cart", cart);
            model.addAttribute("total", cart.stream().mapToLong(CartItem::getSubtotal).sum());
            return "checkout";
        }

        try {
            int orderId = orderDAO.createOrder(user.getId(), fullName, phone, address, note, cart);
            session.removeAttribute("cart");
            return "redirect:/orders?success=" + orderId;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
