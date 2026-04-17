package com.techzone.controller;

import com.techzone.dao.ProductDAO;
import com.techzone.model.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ProductDAO productDAO;

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @GetMapping
    public String getCartPage(HttpSession session, Model model) {
        List<CartItem> cart = getCart(session);
        enrichCart(cart);
        model.addAttribute("cart", cart);
        model.addAttribute("total", cart.stream().mapToLong(CartItem::getSubtotal).sum());
        return "cart";
    }

    @PostMapping
    public String modifyCart(
            @RequestParam(required = false, defaultValue = "") String action,
            @RequestParam(required = false) String productId,
            @RequestParam(required = false) String qty,
            @RequestParam(required = false) String redirect,
            HttpSession session) {

        List<CartItem> cart = getCart(session);

        try {
            switch (action) {
                case "add": {
                    int pid = Integer.parseInt(productId);
                    int q = qty != null ? Integer.parseInt(qty) : 1;
                    CartItem existing = cart.stream().filter(i -> i.getProductId() == pid).findFirst().orElse(null);
                    if (existing != null)
                        existing.setQuantity(existing.getQuantity() + q);
                    else
                        cart.add(new CartItem(pid, q));
                    break;
                }
                case "remove": {
                    int pid = Integer.parseInt(productId);
                    cart.removeIf(i -> i.getProductId() == pid);
                    break;
                }
                case "update": {
                    int pid = Integer.parseInt(productId);
                    int q = Integer.parseInt(qty);
                    if (q <= 0)
                        cart.removeIf(i -> i.getProductId() == pid);
                    else
                        cart.stream().filter(i -> i.getProductId() == pid)
                                .findFirst().ifPresent(i -> i.setQuantity(q));
                    break;
                }
                case "clear":
                    cart.clear();
                    break;
            }
        } catch (Exception ignored) {
        }

        if (redirect != null && !redirect.isEmpty()) {
            return "redirect:" + redirect;
        }
        return "redirect:/cart";
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
}
