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
public class FeedbackFacade extends AbstractFacade<Feedback> {

    @PersistenceContext(unitName = "EPDA_Assignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FeedbackFacade() {
        super(Feedback.class);
    }

    // Custom: Find all feedback for a specific customer
    public List<Feedback> findByCustomerId(Long customerId) {
        TypedQuery<Feedback> query = em.createQuery(
            "SELECT f FROM Feedback f WHERE f.customer.customerId = :customerId", Feedback.class);
        query.setParameter("customerId", customerId);
        return query.getResultList();
    }

    // Custom: Find all feedback for a specific car
    public List<Feedback> findByCarId(Long carId) {
        TypedQuery<Feedback> query = em.createQuery(
            "SELECT f FROM Feedback f WHERE f.car.carId = :carId", Feedback.class);
        query.setParameter("carId", carId);
        return query.getResultList();
    }

    // Custom: Find feedback by rating range
    public List<Feedback> findByRatingRange(double minRating, double maxRating) {
        TypedQuery<Feedback> query = em.createQuery(
            "SELECT f FROM Feedback f WHERE f.rating BETWEEN :minRating AND :maxRating", Feedback.class);
        query.setParameter("minRating", minRating);
        query.setParameter("maxRating", maxRating);
        return query.getResultList();
    }
}
