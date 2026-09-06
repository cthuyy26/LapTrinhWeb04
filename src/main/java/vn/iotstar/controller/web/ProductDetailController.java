package vn.iotstar.controller.web;

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
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/product/detail", "/product-detail" })
public class ProductDetailController extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            Product product = productService.get(id);

            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/product");
                return;
            }

            // Lấy các sản phẩm liên quan cùng danh mục
            int categoryId = (product.getCategory() != null) ? product.getCategory().getId() : 1;
            List<Product> relatedProducts = productService.getRelatedProducts(categoryId, product.getId(), 4);

            req.setAttribute("product", product);
            req.setAttribute("relatedProducts", relatedProducts);

            RequestDispatcher dispatcher = req.getRequestDispatcher(Constant.Path.PRODUCT_DETAIL);
            dispatcher.forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }
}
