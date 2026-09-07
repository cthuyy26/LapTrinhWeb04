package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
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
@WebServlet(urlPatterns = { "/admin/product/add" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProductAddController extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categoryList = categoryService.getAll();
        req.setAttribute("categoryList", categoryList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/product/add-product.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String statusStr = req.getParameter("status");
        String cateIdStr = req.getParameter("categoryId");

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên sản phẩm không được để trống!");
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/add-product.jsp").forward(req, resp);
            return;
        }

        double price = 0;
        int quantity = 0;
        int status = 1;
        int cateId = 1;

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
            if (cateIdStr != null && !cateIdStr.trim().isEmpty()) {
                cateId = Integer.parseInt(cateIdStr.trim());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (price <= 0) {
            req.setAttribute("error", "Đơn giá sản phẩm phải lớn hơn 0 VNĐ!");
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/add-product.jsp").forward(req, resp);
            return;
        }

        if (quantity < 0) {
            req.setAttribute("error", "Số lượng sản phẩm không được là số âm!");
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/add-product.jsp").forward(req, resp);
            return;
        }

        Category category = categoryService.get(cateId);
        if (category == null) {
            category = new Category(cateId, "Danh Mục Mặc Định", null, 1);
        }

        Product product = new Product();
        product.setName(name.trim());
        product.setDescription(description);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setStatus(status);
        product.setCategory(category);
        product.setCreateDate(new Date());

        // Xử lý upload file hình ảnh Multipart
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
            } else {
                product.setImage(null);
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi thêm sản phẩm: " + e.getMessage());
            req.setAttribute("categoryList", categoryService.getAll());
            req.getRequestDispatcher("/views/admin/product/add-product.jsp").forward(req, resp);
        }
    }
}
