package vn.iotstar.controller.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/image") // ?fname=abc.png
public class DownloadImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        File file = (fileName != null && !fileName.isEmpty() && !fileName.equals("null")) ? new File(Constant.DIR + "/" + fileName) : null;

        // Nếu file tồn tại thực tế trên ổ đĩa -> stream file ảnh
        if (file != null && file.exists() && file.isFile()) {
            String mimeType = req.getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "image/jpeg";
            }
            resp.setContentType(mimeType);

            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = resp.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
            }
            return;
        }

        // Ảnh mặc định SVG chất lượng cao khi tài khoản chưa có avatar hoặc file không tồn tại
        resp.setContentType("image/svg+xml");
        resp.setCharacterEncoding("UTF-8");
        String defaultAvatarSvg = "<svg xmlns='http://www.w3.org/2000/svg' width='140' height='140' viewBox='0 0 140 140'>"
                + "<circle cx='70' cy='70' r='70' fill='#0284c7'/>"
                + "<circle cx='70' cy='52' r='24' fill='#ffffff'/>"
                + "<path d='M25 118 c0 -26, 22 -40, 45 -40 s45 14, 45 40 Z' fill='#ffffff'/>"
                + "</svg>";
        resp.getWriter().write(defaultAvatarSvg);
    }
}
