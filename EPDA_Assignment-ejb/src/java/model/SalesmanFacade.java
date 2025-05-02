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
import javax.persistence.NoResultException;
import java.util.List;

@Stateless
public class SalesmanFacade extends AbstractFacade<Salesman> {

    @PersistenceContext(unitName = "EPDA_Assignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SalesmanFacade() {
        super(Salesman.class);
    }

    // Custom: Authenticate login
    public Salesman login(String username, String password) {
        try {
            TypedQuery<Salesman> query = em.createQuery(
                "SELECT s FROM Salesman s WHERE s.username = :username AND s.password = :password", Salesman.class);
            query.setParameter("username", username);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // Custom: Find by username
    public Salesman findByUsername(String username) {
        try {
            TypedQuery<Salesman> query = em.createQuery(
                "SELECT s FROM Salesman s WHERE s.username = :username", Salesman.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // Custom: Search salesmen by username (partial match)
    public List<Salesman> searchByName(String username) {
        TypedQuery<Salesman> query = em.createQuery(
            "SELECT s FROM Salesman s WHERE LOWER(s.username) LIKE :username", Salesman.class);
        query.setParameter("username", "%" + username.toLowerCase() + "%");
        return query.getResultList();
    }
}
