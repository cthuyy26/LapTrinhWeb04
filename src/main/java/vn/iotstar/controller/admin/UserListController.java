package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/admin/user/list", "/admin/users" })
public class UserListController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User currentAdmin = (User) session.getAttribute("account");
        if (currentAdmin.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        String keyword = req.getParameter("keyword");
        List<User> userList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            userList = userService.search(keyword.trim());
            req.setAttribute("keyword", keyword.trim());
        } else {
            userList = userService.findAll();
        }

        req.setAttribute("userList", userList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/user/list-user.jsp");
        dispatcher.forward(req, resp);
    }
}
