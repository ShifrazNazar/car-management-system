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
import java.util.Date;
import java.util.List;

@Stateless
public class SaleFacade extends AbstractFacade<Sale> {

    @PersistenceContext(unitName = "EPDA_Assignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SaleFacade() {
        super(Sale.class);
    }

    // Custom: Get all sales by salesman
    public List<Sale> findBySalesmanId(Long salesmanId) {
        TypedQuery<Sale> query = em.createQuery(
            "SELECT s FROM Sale s WHERE s.salesman.id = :salesmanId", Sale.class);
        query.setParameter("salesmanId", salesmanId);
        return query.getResultList();
    }

    // Custom: Get all sales by customer
    public List<Sale> findByCustomerId(Long customerId) {
        TypedQuery<Sale> query = em.createQuery(
            "SELECT s FROM Sale s WHERE s.customer.id = :customerId", Sale.class);
        query.setParameter("customerId", customerId);
        return query.getResultList();
    }

    // Custom: Get all sales by status (e.g., paid, booked, canceled)
    public List<Sale> findByStatus(String status) {
        TypedQuery<Sale> query = em.createQuery(
            "SELECT s FROM Sale s WHERE LOWER(s.status) = :status", Sale.class);
        query.setParameter("status", status.toLowerCase());
        return query.getResultList();
    }

    // Custom: Filter sales by date range
    public List<Sale> findByDateRange(Date startDate, Date endDate) {
        TypedQuery<Sale> query = em.createQuery(
            "SELECT s FROM Sale s WHERE s.saleDate BETWEEN :start AND :end", Sale.class);
        query.setParameter("start", startDate);
        query.setParameter("end", endDate);
        return query.getResultList();
    }
}

