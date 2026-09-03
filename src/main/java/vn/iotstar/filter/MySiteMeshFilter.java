package vn.iotstar.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // 1. Loại trừ các tài nguyên tĩnh, controller ảnh và các thành phần nhúng
        builder.addExcludedPath("/decorators/*")
               .addExcludedPath("/WEB-INF/decorators/*")
               .addExcludedPath("/common/*")
               .addExcludedPath("/image*")
               .addExcludedPath("/static/*")
               .addExcludedPath("/template/*")
               .addExcludedPath("/assets/*");

        // 2. SiteMesh 3 tự động gắn tiền tố mặc định /WEB-INF/decorators/
        // Do đó chỉ cần truyền tên file: "admin.jsp" và "web.jsp"
        builder.addDecoratorPath("/admin/*", "/admin.jsp");
        builder.addDecoratorPath("/*", "/web.jsp");
    }
}
