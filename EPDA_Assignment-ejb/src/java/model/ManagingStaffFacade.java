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

    // Custom: Find staff by username 
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

    // Custom: Search by username (partial match)
    public List<ManagingStaff> searchByName(String username) {
        TypedQuery<ManagingStaff> query = em.createQuery(
            "SELECT m FROM ManagingStaff m WHERE LOWER(m.username) LIKE :username", ManagingStaff.class);
        query.setParameter("username", "%" + username.toLowerCase() + "%");
        return query.getResultList();
    }
}
