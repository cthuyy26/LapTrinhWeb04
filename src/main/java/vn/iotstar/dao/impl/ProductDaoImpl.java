package vn.iotstar.dao.impl;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements ProductDao {

    @Override
    public void insert(Product product) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return;
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return;
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return;
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product product = em.find(Product.class, id);
            if (product != null) {
                em.remove(product);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public Product get(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return null;
        try {
            return em.find(Product.class, id);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Product> getAll() {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return new ArrayList<>();
        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.id DESC";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Product> search(String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return new ArrayList<>();
        try {
            String jpql = "SELECT p FROM Product p WHERE p.name LIKE :kw OR p.description LIKE :kw ORDER BY p.id DESC";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Product> getTop10() {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return new ArrayList<>();
        try {
            String jpql = "SELECT p FROM Product p WHERE p.status = 1 ORDER BY p.createDate DESC, p.id DESC";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Product> getProductsByPage(int page, int pageSize, Integer categoryId, String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return new ArrayList<>();
        try {
            StringBuilder jpql = new StringBuilder("SELECT p FROM Product p WHERE p.status = 1");
            if (categoryId != null && categoryId > 0) {
                jpql.append(" AND p.category.id = :cateId");
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND (p.name LIKE :kw OR p.description LIKE :kw)");
            }
            jpql.append(" ORDER BY p.id DESC");

            TypedQuery<Product> query = em.createQuery(jpql.toString(), Product.class);
            if (categoryId != null && categoryId > 0) {
                query.setParameter("cateId", categoryId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + keyword.trim() + "%");
            }

            int firstResult = (page - 1) * pageSize;
            query.setFirstResult(Math.max(0, firstResult));
            query.setMaxResults(pageSize);

            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public int countProducts(Integer categoryId, String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return 0;
        try {
            StringBuilder jpql = new StringBuilder("SELECT COUNT(p) FROM Product p WHERE p.status = 1");
            if (categoryId != null && categoryId > 0) {
                jpql.append(" AND p.category.id = :cateId");
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND (p.name LIKE :kw OR p.description LIKE :kw)");
            }

            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (categoryId != null && categoryId > 0) {
                query.setParameter("cateId", categoryId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + keyword.trim() + "%");
            }

            Long count = query.getSingleResult();
            return count != null ? count.intValue() : 0;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Product> getRelatedProducts(int categoryId, int currentProductId, int limit) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return new ArrayList<>();
        try {
            String jpql = "SELECT p FROM Product p WHERE p.category.id = :cateId AND p.id != :curId AND p.status = 1 ORDER BY p.id DESC";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("cateId", categoryId);
            query.setParameter("curId", currentProductId);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }
}
