package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product;

public interface ProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product get(int id);
    List<Product> getAll();
    List<Product> search(String keyword);
    
    // 10 sản phẩm mới nhất cho trang chủ
    List<Product> getTop10();

    // Phân trang sản phẩm linh hoạt (hỗ trợ lọc theo category và search)
    List<Product> getProductsByPage(int page, int pageSize, Integer categoryId, String keyword);
    int countProducts(Integer categoryId, String keyword);

    // Lấy danh sách sản phẩm liên quan cùng danh mục
    List<Product> getRelatedProducts(int categoryId, int currentProductId, int limit);
}
