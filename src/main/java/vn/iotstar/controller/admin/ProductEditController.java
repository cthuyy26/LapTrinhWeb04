package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/admin/product/edit" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProductEditController extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Product product = productService.get(id);
                List<Category> categoryList = categoryService.getAll();
                req.setAttribute("product", product);
                req.setAttribute("categoryList", categoryList);
                RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/product/edit-product.jsp");
                dispatcher.forward(req, resp);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/product/list");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String statusStr = req.getParameter("status");
        String cateIdStr = req.getParameter("categoryId");

        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
            return;
        }

        int id = Integer.parseInt(idStr);
        Product product = productService.get(id);
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
            return;
        }

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên sản phẩm không được để trống!");
            req.setAttribute("product", product);
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/edit-product.jsp").forward(req, resp);
            return;
        }

        double price = product.getPrice();
        int quantity = product.getQuantity();
        int status = product.getStatus();

        try {
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                price = Double.parseDouble(priceStr.trim());
            }
            if (quantityStr != null && !quantityStr.trim().isEmpty()) {
                quantity = Integer.parseInt(quantityStr.trim());
            }
            if (statusStr != null && !statusStr.trim().isEmpty()) {
                status = Integer.parseInt(statusStr.trim());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (price <= 0) {
            req.setAttribute("error", "Đơn giá sản phẩm phải lớn hơn 0 VNĐ!");
            req.setAttribute("product", product);
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/edit-product.jsp").forward(req, resp);
            return;
        }

        if (quantity < 0) {
            req.setAttribute("error", "Số lượng sản phẩm không được là số âm!");
            req.setAttribute("product", product);
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/edit-product.jsp").forward(req, resp);
            return;
        }

        try {
            product.setName(name.trim());
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);

            if (cateIdStr != null && !cateIdStr.trim().isEmpty()) {
                int cateId = Integer.parseInt(cateIdStr.trim());
                Category cat = categoryService.get(cateId);
                if (cat != null) {
                    product.setCategory(cat);
                }
            }

            // Xử lý upload ảnh mới nếu có
            try {
                Part filePart = req.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String ext = "";
                    int idx = submittedFileName.lastIndexOf(".");
                    if (idx >= 0) {
                        ext = submittedFileName.substring(idx);
                    }
                    String fileName = "product_" + System.currentTimeMillis() + ext;
                    File uploadDir = new File(Constant.DIR + "/product");
                    if (!uploadDir.exists()) uploadDir.mkdirs();

                    filePart.write(new File(uploadDir, fileName).getAbsolutePath());
                    product.setImage("product/" + fileName);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            req.setAttribute("product", product);
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/edit-product.jsp").forward(req, resp);
        }
    }
}
