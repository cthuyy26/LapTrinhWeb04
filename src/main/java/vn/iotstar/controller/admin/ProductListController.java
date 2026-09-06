package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/admin/product/list" })
public class ProductListController extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Product> productList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productService.search(keyword.trim());
            req.setAttribute("keyword", keyword);
        } else {
            productList = productService.getAll();
        }

        req.setAttribute("productList", productList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/product/list-product.jsp");
        dispatcher.forward(req, resp);
    }
}
