package com.techzone.controller;

import com.techzone.dao.ProductDAO;
import com.techzone.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping
    public String getProductDetail(@RequestParam(required = false) String id, Model model) {
        if (id == null) {
            return "redirect:/";
        }

        try {
            int productId = Integer.parseInt(id);
            Product product = productDAO.getById(productId);
            if (product == null) {
                return "redirect:/";
            }
            model.addAttribute("product", product);
            return "product-detail";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
