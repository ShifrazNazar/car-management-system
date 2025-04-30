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

    // Custom: Get feedback by customer
    public List<Feedback> findByCustomerId(Long customerId) {
        TypedQuery<Feedback> query = em.createQuery(
            "SELECT f FROM Feedback f WHERE f.customer.id = :customerId", Feedback.class);
        query.setParameter("customerId", customerId);
        return query.getResultList();
    }

    // Custom: Get feedback by car
    public List<Feedback> findByCarId(Long carId) {
        TypedQuery<Feedback> query = em.createQuery(
            "SELECT f FROM Feedback f WHERE f.car.id = :carId", Feedback.class);
        query.setParameter("carId", carId);
        return query.getResultList();
    }

    // Custom: Get feedback by rating (e.g., for reports)
    public List<Feedback> findByRating(int rating) {
        TypedQuery<Feedback> query = em.createQuery(
            "SELECT f FROM Feedback f WHERE f.rating = :rating", Feedback.class);
        query.setParameter("rating", rating);
        return query.getResultList();
    }
}
