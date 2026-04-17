package com.techzone.controller;

import com.techzone.dao.ProductDAO;
import com.techzone.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping({ "", "/", "/home" })
public class HomeController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping
    public String home(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String sort,
            HttpServletRequest req) {

        List<Product> products;
        if (search != null && !search.trim().isEmpty()) {
            products = productDAO.search(search.trim());
            req.setAttribute("search", search.trim());
        } else if (category != null && !category.trim().isEmpty() && !category.equals("Tất cả")) {
            products = productDAO.getByCategory(category.trim());
            req.setAttribute("activeCategory", category.trim());
        } else {
            products = productDAO.getAll();
        }

        // Sort
        if ("price-asc".equals(sort))
            products.sort((a, b) -> Long.compare(a.getPrice(), b.getPrice()));
        if ("price-desc".equals(sort))
            products.sort((a, b) -> Long.compare(b.getPrice(), a.getPrice()));
        if ("rating".equals(sort))
            products.sort((a, b) -> Double.compare(b.getRating(), a.getRating()));

        req.setAttribute("products", products);
        req.setAttribute("categories", productDAO.getCategories());
        req.setAttribute("sort", sort);

        return "index";
    }
}
