package vn.iotstar.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import vn.iotstar.dao.ProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;

public class ProductServiceImpl implements ProductService {

    private ProductDao productDao = new ProductDaoImpl();

    // Mock products data dự phòng
    private static final Map<Integer, Product> mockProducts = new ConcurrentHashMap<>();
    private static int currentMockId = 15;

    static {
        Category cPhone = new Category(1, "Điện Thoại & Tablet", "category/phone.png", 1);
        Category cLaptop = new Category(2, "Laptop & Máy Tính", "category/laptop.png", 1);
        Category cAccessory = new Category(3, "Phụ Kiện Công Nghệ", "category/accessories.png", 1);
        Category cWatch = new Category(4, "Đồng Hồ Thông Minh", "category/smartwatch.png", 1);
        Category cAudio = new Category(5, "Thiết Bị Âm Thanh", "category/audio.png", 1);

        long now = System.currentTimeMillis();

        mockProducts.put(1, new Product(1, "iPhone 15 Pro Max 256GB", "Màn hình Super Retina XDR 6.7 inch, chip Apple A17 Pro mạnh mẽ, khung titan sang trọng siêu bền.", 29490000, "product/iphone15promax.png", 50, new Date(now - 60000), 1, cPhone));
        mockProducts.put(2, new Product(2, "Samsung Galaxy S24 Ultra 5G", "Màn hình Dynamic AMOLED 2X 6.8 inch, tích hợp Galaxy AI đột phá, camera 200MP, bút S-Pen chuyên nghiệp.", 27990000, "product/s24ultra.png", 40, new Date(now - 120000), 1, cPhone));
        mockProducts.put(3, new Product(3, "MacBook Pro 14 M3 Pro 2024", "Chip Apple M3 Pro 11-core CPU, 14-core GPU, màn hình Liquid Retina XDR 120Hz mượt mà, thời lượng pin 18h.", 49990000, "product/macbookm3.png", 20, new Date(now - 180000), 1, cLaptop));
        mockProducts.put(4, new Product(4, "Laptop Dell XPS 13 Plus 9320", "Thiết kế nhôm nguyên khối siêu mỏng nhẹ, màn hình 13.4 inch OLED 3.5K cảm ứng, Intel Core i7 thế hệ 13.", 38500000, "product/dellxps.png", 15, new Date(now - 240000), 1, cLaptop));
        mockProducts.put(5, new Product(5, "iPad Pro M4 11 inch Wi-Fi 256GB", "Màn hình Ultra Retina XDR OLED kép siêu sáng, độ mỏng ấn tượng chỉ 5.3mm, chip M4 đỉnh cao.", 26890000, "product/ipadm4.png", 30, new Date(now - 300000), 1, cPhone));
        mockProducts.put(6, new Product(6, "Sony WH-1000XM5 Chống Ồn", "Tai nghe chụp tai chống ồn hàng đầu thế giới, âm thanh Hi-Res Audio, thời lượng pin liên tục đến 30 giờ.", 7490000, "product/sonywh1000.png", 60, new Date(now - 360000), 1, cAudio));
        mockProducts.put(7, new Product(7, "Apple Watch Ultra 2 GPS + Cellular", "Vỏ titan 49mm chuẩn quân đội, GPS tần số kép chính xác, màn hình 3000 nits siêu sáng ngoài trời.", 19990000, "product/applewatchultra.png", 25, new Date(now - 420000), 1, cWatch));
        mockProducts.put(8, new Product(8, "Tai nghe AirPods Pro 2 USB-C", "Chíp H2, chống ồn chủ động gấp 2 lần thế hệ trước, âm thanh thích ứng và cổng sạc Type-C tiện lợi.", 5390000, "product/airpodspro2.png", 100, new Date(now - 480000), 1, cAudio));
        mockProducts.put(9, new Product(9, "Laptop Asus ROG Zephyrus G16", "Laptop gaming cao cấp màn hình ROG Nebula OLED 240Hz, CPU Intel Core Ultra 9, card đồ họa RTX 4070.", 54990000, "product/asusrog.png", 12, new Date(now - 540000), 1, cLaptop));
        mockProducts.put(10, new Product(10, "Samsung Galaxy Watch 6 Classic", "Viền xoay vật lý trứ danh, màn hình Sapphire cao cấp, theo dõi thành phần cơ thể và phân tích giấc ngủ sâu.", 6990000, "product/galaxywatch6.png", 35, new Date(now - 600000), 1, cWatch));
        mockProducts.put(11, new Product(11, "Bàn phím cơ không dây Logitech MX Mechanical", "Tactile Quiet switch êm ái, kết nối đa thiết bị qua Bluetooth/Logi Bolt, đèn nền thông minh tự phát sáng.", 3690000, "product/logitechmx.png", 80, new Date(now - 660000), 1, cAccessory));
        mockProducts.put(12, new Product(12, "Chuột không dây Logitech MX Master 3S", "Cảm biến 8000 DPI trên mọi bề mặt, cuộn MagSpeed 1000 dòng/giây siêu tốc, công tắc Quiet Clicks giảm 90% tiếng ồn.", 2190000, "product/mxmaster3s.png", 90, new Date(now - 720000), 1, cAccessory));
        mockProducts.put(13, new Product(13, "Loa Bluetooth Marshall Stanmore III", "Âm thanh Stereo sống động trường âm rộng hơn, thiết kế cổ điển phong cách Vintage đậm chất Rock.", 8990000, "product/marshall.png", 22, new Date(now - 780000), 1, cAudio));
        mockProducts.put(14, new Product(14, "Củ sạc nhanh Anker 735 GaNPrime 65W", "Công nghệ sạc nhanh GaNPrime 3 cổng (2 USB-C, 1 USB-A), công suất tối đa 65W cho laptop và điện thoại.", 1190000, "product/anker65w.png", 120, new Date(now - 840000), 1, cAccessory));
        mockProducts.put(15, new Product(15, "Xiaomi 14 Ultra 5G Leica", "Bộ 4 camera Leica 50MP cảm biến 1 inch khẩu độ vô cấp, chip Snapdragon 8 Gen 3 cực khủng.", 24990000, "product/xiaomi14ultra.png", 18, new Date(now - 900000), 1, cPhone));
    }

    @Override
    public void insert(Product product) {
        try {
            productDao.insert(product);
        } catch (Exception e) {
            System.err.println("Lỗi insert ProductDao: " + e.getMessage());
        }
        if (product.getId() == 0) {
            currentMockId++;
            product.setId(currentMockId);
        }
        mockProducts.put(product.getId(), product);
    }

    @Override
    public void update(Product product) {
        try {
            productDao.update(product);
        } catch (Exception e) {
            System.err.println("Lỗi update ProductDao: " + e.getMessage());
        }
        mockProducts.put(product.getId(), product);
    }

    @Override
    public void delete(int id) {
        try {
            productDao.delete(id);
        } catch (Exception e) {
            System.err.println("Lỗi delete ProductDao: " + e.getMessage());
        }
        mockProducts.remove(id);
    }

    @Override
    public Product get(int id) {
        try {
            Product p = productDao.get(id);
            if (p != null) return p;
        } catch (Exception e) {
            System.err.println("Lỗi get ProductDao: " + e.getMessage());
        }
        return mockProducts.get(id);
    }

    @Override
    public List<Product> getAll() {
        try {
            List<Product> list = productDao.getAll();
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("Lỗi getAll ProductDao: " + e.getMessage());
        }
        return mockProducts.values().stream()
                .sorted((a, b) -> Integer.compare(b.getId(), a.getId()))
                .collect(Collectors.toList());
    }

    @Override
    public List<Product> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return this.getAll();
        }
        try {
            List<Product> list = productDao.search(keyword.trim());
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("Lỗi search ProductDao: " + e.getMessage());
        }

        String kw = keyword.toLowerCase().trim();
        return mockProducts.values().stream()
                .filter(p -> (p.getName() != null && p.getName().toLowerCase().contains(kw))
                        || (p.getDescription() != null && p.getDescription().toLowerCase().contains(kw)))
                .sorted((a, b) -> Integer.compare(b.getId(), a.getId()))
                .collect(Collectors.toList());
    }

    @Override
    public List<Product> getTop10() {
        try {
            List<Product> list = productDao.getTop10();
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("Lỗi getTop10 ProductDao: " + e.getMessage());
        }

        return mockProducts.values().stream()
                .filter(p -> p.getStatus() == 1)
                .sorted((a, b) -> {
                    if (a.getCreateDate() != null && b.getCreateDate() != null) {
                        return b.getCreateDate().compareTo(a.getCreateDate());
                    }
                    return Integer.compare(b.getId(), a.getId());
                })
                .limit(10)
                .collect(Collectors.toList());
    }

    @Override
    public List<Product> getProductsByPage(int page, int pageSize, Integer categoryId, String keyword) {
        try {
            List<Product> list = productDao.getProductsByPage(page, pageSize, categoryId, keyword);
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("Lỗi getProductsByPage ProductDao: " + e.getMessage());
        }

        List<Product> filtered = mockProducts.values().stream()
                .filter(p -> p.getStatus() == 1)
                .filter(p -> categoryId == null || categoryId <= 0 || (p.getCategory() != null && p.getCategory().getId() == categoryId))
                .filter(p -> keyword == null || keyword.trim().isEmpty() || (p.getName() != null && p.getName().toLowerCase().contains(keyword.toLowerCase().trim())) || (p.getDescription() != null && p.getDescription().toLowerCase().contains(keyword.toLowerCase().trim())))
                .sorted((a, b) -> Integer.compare(b.getId(), a.getId()))
                .collect(Collectors.toList());

        int fromIndex = (page - 1) * pageSize;
        if (fromIndex >= filtered.size()) {
            return new ArrayList<>();
        }
        int toIndex = Math.min(fromIndex + pageSize, filtered.size());
        return filtered.subList(fromIndex, toIndex);
    }

    @Override
    public int countProducts(Integer categoryId, String keyword) {
        try {
            int count = productDao.countProducts(categoryId, keyword);
            if (count > 0) {
                return count;
            }
        } catch (Exception e) {
            System.err.println("Lỗi countProducts ProductDao: " + e.getMessage());
        }

        long count = mockProducts.values().stream()
                .filter(p -> p.getStatus() == 1)
                .filter(p -> categoryId == null || categoryId <= 0 || (p.getCategory() != null && p.getCategory().getId() == categoryId))
                .filter(p -> keyword == null || keyword.trim().isEmpty() || (p.getName() != null && p.getName().toLowerCase().contains(keyword.toLowerCase().trim())) || (p.getDescription() != null && p.getDescription().toLowerCase().contains(keyword.toLowerCase().trim())))
                .count();
        return (int) count;
    }

    @Override
    public List<Product> getRelatedProducts(int categoryId, int currentProductId, int limit) {
        try {
            List<Product> list = productDao.getRelatedProducts(categoryId, currentProductId, limit);
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("Lỗi getRelatedProducts ProductDao: " + e.getMessage());
        }

        return mockProducts.values().stream()
                .filter(p -> p.getStatus() == 1 && p.getId() != currentProductId && p.getCategory() != null && p.getCategory().getId() == categoryId)
                .sorted((a, b) -> Integer.compare(b.getId(), a.getId()))
                .limit(limit)
                .collect(Collectors.toList());
    }
}
