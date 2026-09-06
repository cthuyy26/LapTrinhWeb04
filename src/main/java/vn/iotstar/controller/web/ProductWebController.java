package vn.iotstar.controller.web;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/product", "/products" })
public class ProductWebController extends HttpServlet {
    private static final int PAGE_SIZE = 6; // Đề bài yêu cầu: 6 sản phẩm / trang

    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pageStr = req.getParameter("page");
        String cateIdStr = req.getParameter("categoryId");
        String keyword = req.getParameter("keyword");

        int page = 1;
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageStr.trim());
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        Integer categoryId = null;
        if (cateIdStr != null && !cateIdStr.trim().isEmpty()) {
            try {
                int cid = Integer.parseInt(cateIdStr.trim());
                if (cid > 0) categoryId = cid;
            } catch (NumberFormatException ignored) {}
        }

        if (keyword != null) {
            keyword = keyword.trim();
        }

        // Đếm tổng số sản phẩm thỏa điều kiện lọc
        int totalProducts = productService.countProducts(categoryId, keyword);
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
        if (totalPages < 1) {
            totalPages = 1;
        }

        if (page > totalPages) {
            page = totalPages;
        }

        // Lấy danh sách 6 sản phẩm cho trang hiện tại
        List<Product> productList = productService.getProductsByPage(page, PAGE_SIZE, categoryId, keyword);
        List<Category> categoryList = categoryService.getAll();

        req.setAttribute("productList", productList);
        req.setAttribute("categoryList", categoryList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("selectedCategoryId", categoryId);
        req.setAttribute("keyword", keyword);

        RequestDispatcher dispatcher = req.getRequestDispatcher(Constant.Path.PRODUCT_LIST);
        dispatcher.forward(req, resp);
    }
}
