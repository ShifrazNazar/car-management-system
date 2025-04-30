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
public class ManagingStaffFacade extends AbstractFacade<ManagingStaff> {

    @PersistenceContext(unitName = "EPDA_Assignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ManagingStaffFacade() {
        super(ManagingStaff.class);
    }

    // Custom: Find staff by username (for login)
    public ManagingStaff findByUsername(String username) {
        try {
            TypedQuery<ManagingStaff> query = em.createQuery(
                "SELECT m FROM ManagingStaff m WHERE m.username = :username", ManagingStaff.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // Custom: Authenticate staff login
    public ManagingStaff login(String username, String password) {
        try {
            TypedQuery<ManagingStaff> query = em.createQuery(
                "SELECT m FROM ManagingStaff m WHERE m.username = :username AND m.password = :password", ManagingStaff.class);
            query.setParameter("username", username);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // Custom: Search by name (partial match)
    public List<ManagingStaff> searchByName(String name) {
        TypedQuery<ManagingStaff> query = em.createQuery(
            "SELECT m FROM ManagingStaff m WHERE LOWER(m.name) LIKE :name", ManagingStaff.class);
        query.setParameter("name", "%" + name.toLowerCase() + "%");
        return query.getResultList();
    }
}
