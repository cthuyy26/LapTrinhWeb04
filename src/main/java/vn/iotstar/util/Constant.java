package vn.iotstar.util;

import java.io.File;

public class Constant {
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";

    // Thư mục lưu trữ hình ảnh upload chuyển vào trong thư mục dự án
    public static final String DIR = "D:/ShoppingServletServiceMVC/upload";

    static {
        File dirCategory = new File(DIR + "/category");
        if (!dirCategory.exists()) {
            dirCategory.mkdirs();
        }
        File dirUser = new File(DIR + "/user");
        if (!dirUser.exists()) {
            dirUser.mkdirs();
        }
        File dirProduct = new File(DIR + "/product");
        if (!dirProduct.exists()) {
            dirProduct.mkdirs();
        }
    }

    public static class Path {
        public static final String LOGIN = "/views/login.jsp";
        public static final String REGISTER = "/views/register.jsp";
        public static final String VERIFY_REGISTER_OTP = "/views/verify-register-otp.jsp";
        public static final String FORGOT_PASSWORD = "/views/forgot-password.jsp";
        public static final String RESET_PASSWORD = "/views/reset-password.jsp";
        public static final String HOME = "/views/web/home.jsp";
        public static final String PRODUCT_LIST = "/views/web/product-list.jsp";
        public static final String PRODUCT_DETAIL = "/views/web/product-detail.jsp";
        public static final String PROFILE = "/views/web/profile.jsp";
    }
}
