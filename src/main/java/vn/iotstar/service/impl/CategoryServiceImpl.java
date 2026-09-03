package vn.iotstar.service.impl;

import java.io.File;
import java.util.List;

import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.entity.Category; // <-- Dùng Entity JPA
import vn.iotstar.service.CategoryService;
import vn.iotstar.util.Constant;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());
        if (oldCategory != null) {
            oldCategory.setName(newCategory.getName());
            
            // Nếu người dùng có chọn ảnh mới thì xóa ảnh cũ trên ổ cứng đi
            if (newCategory.getIcon() != null) {
                String fileName = oldCategory.getIcon();
                if (fileName != null) {
                    File file = new File(Constant.DIR + "/" + fileName);
                    if (file.exists()) {
                        file.delete();
                    }
                }
                oldCategory.setIcon(newCategory.getIcon());
            }
            categoryDao.edit(oldCategory);
        }
    }

    @Override
    public void delete(int id) {
        Category category = categoryDao.get(id);
        if (category != null) {
            // Xóa file ảnh tương ứng trên ổ cứng khi xóa danh mục
            if (category.getIcon() != null) {
                File file = new File(Constant.DIR + "/" + category.getIcon());
                if (file.exists()) {
                    file.delete();
                }
            }
            categoryDao.delete(id);
        }
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.search(keyword);
    }
}
