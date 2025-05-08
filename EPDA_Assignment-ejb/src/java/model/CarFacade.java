/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class CarFacade extends AbstractFacade<Car> {

    @PersistenceContext(unitName = "EPDA_Assignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CarFacade() {
        super(Car.class);
    }

    public List<Car> findBySalesmanId(Long salesmanId) {
        TypedQuery<Car> query = em.createQuery(
                "SELECT c FROM Car c WHERE c.salesman.salesmanId = :salesmanId", Car.class);
        query.setParameter("salesmanId", salesmanId);
        return query.getResultList();
    }

    // Custom: Search cars by status (e.g., available, booked)
    public List<Car> findByStatus(String status) {
        TypedQuery<Car> query = em.createQuery(
                "SELECT c FROM Car c WHERE LOWER(c.status) = :status", Car.class);
        query.setParameter("status", status.toLowerCase());
        return query.getResultList();
    }

    // Custom: Search cars by model keyword
    public List<Car> searchByModel(String keyword) {
        TypedQuery<Car> query = em.createQuery(
                "SELECT c FROM Car c WHERE LOWER(c.model) LIKE :keyword", Car.class);
        query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
        return query.getResultList();
    }

    // Custom: Get all available cars
    public List<Car> findAvailableCars() {
        return findByStatus("available");
    }
}
