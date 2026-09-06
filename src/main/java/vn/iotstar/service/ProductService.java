package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Product;

public interface ProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product get(int id);
    List<Product> getAll();
    List<Product> search(String keyword);
    
    // Top 10 sản phẩm mới nhất
    List<Product> getTop10();

    // Phân trang sản phẩm (mặc định 6 sản phẩm / trang)
    List<Product> getProductsByPage(int page, int pageSize, Integer categoryId, String keyword);
    int countProducts(Integer categoryId, String keyword);

    // Sản phẩm liên quan cùng danh mục
    List<Product> getRelatedProducts(int categoryId, int currentProductId, int limit);
}
