package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/admin/category/add" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class CategoryAddController extends HttpServlet {
    private CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/add-category.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên danh mục không được để trống!");
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
            return;
        }

        Category category = new Category();
        category.setName(name.trim());

        try {
            Part filePart = req.getPart("icon");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int idx = submittedFileName.lastIndexOf(".");
                if (idx >= 0) {
                    ext = submittedFileName.substring(idx);
                }
                String fileName = System.currentTimeMillis() + ext;
                File uploadDir = new File(Constant.DIR + "/category");
                if (!uploadDir.exists()) uploadDir.mkdirs();

                filePart.write(new File(uploadDir, fileName).getAbsolutePath());
                category.setIcon("category/" + fileName);
            } else {
                category.setIcon(null);
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi thêm danh mục: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
        }
    }
}
