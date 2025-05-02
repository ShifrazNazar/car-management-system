/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class CustomerFacade extends AbstractFacade<Customer> {

    @PersistenceContext(unitName = "EPDA_Assignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerFacade() {
        super(Customer.class);
    }

    // Custom: Authenticate login
    public Customer login(String username, String password) {
        try {
            TypedQuery<Customer> query = em.createQuery(
                "SELECT c FROM Customer c WHERE c.username = :username AND c.password = :password", Customer.class);
            query.setParameter("username", username);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // Custom: Find by username (for checking duplicates or fetching)
    public Customer findByUsername(String username) {
        try {
            TypedQuery<Customer> query = em.createQuery(
                "SELECT c FROM Customer c WHERE c.username = :username", Customer.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // Custom: Search by username (partial match)
    public List<Customer> searchByName(String username) {
        TypedQuery<Customer> query = em.createQuery(
            "SELECT c FROM Customer c WHERE LOWER(c.username) LIKE :username", Customer.class);
        query.setParameter("username", "%" + username.toLowerCase() + "%");
        return query.getResultList();
    }
}

