package vn.iotstar.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "Category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int id;

    @Column(name = "cate_name", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String name;

    @Column(name = "icons", columnDefinition = "NVARCHAR(500) NULL")
    private String icon;

    // ĐỔI TỪ int SANG Integer ĐỂ CHẤP NHẬN GIÁ TRỊ NULL
    @Column(name = "status")
    private Integer status = 1;

    // 1. Constructor không tham số (Bắt buộc cho JPA)
    public Category() {
        super();
    }

    // 2. Constructors có tham số
    public Category(int id, String name, String icon, Integer status) {
        super();
        this.id = id;
        this.name = name;
        this.icon = icon;
        this.status = status;
    }

    public Category(String name, String icon) {
        super();
        this.name = name;
        this.icon = icon;
        this.status = 1;
    }

    // 3. Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
