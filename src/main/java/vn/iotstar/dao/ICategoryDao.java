package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Category;

public interface ICategoryDao {
    // Thêm mới danh mục
    void insert(Category category);

    // Cập nhật danh mục
    void edit(Category category);

    // Xóa danh mục theo id
    void delete(int id);

    // Tìm danh mục theo id
    Category get(int id);

    // Tìm danh mục theo tên
    Category get(String name);

    // Lấy toàn bộ danh sách danh mục
    List<Category> getAll();

    // Tìm kiếm danh mục theo từ khóa
    List<Category> search(String keyword);

    // Đếm tổng số lượng danh mục
    int count();
}
