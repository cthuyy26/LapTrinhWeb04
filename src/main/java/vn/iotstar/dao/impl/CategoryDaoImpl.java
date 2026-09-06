package vn.iotstar.dao.impl;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.entity.Category;

public class CategoryDaoImpl implements CategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return;
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
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
    public void edit(Category category) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return;
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
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
            Category category = em.find(Category.class, id);
            if (category != null) {
                em.remove(category);
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
    public Category get(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return null;
        try {
            return em.find(Category.class, id);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public Category get(String name) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return null;
        try {
            String jpql = "SELECT c FROM Category c WHERE c.name = :name";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            query.setParameter("name", name);
            List<Category> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Category> getAll() {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return new ArrayList<>();
        try {
            TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Category> search(String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        if (em == null) return new ArrayList<>();
        try {
            String jpql = "SELECT c FROM Category c WHERE c.name LIKE :kw";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }
}
