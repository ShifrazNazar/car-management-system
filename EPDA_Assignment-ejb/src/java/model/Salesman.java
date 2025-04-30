/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name = "salesman")
public class Salesman implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long salesmanId;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column
    private String email;
    
    @Column
    private String role;

    // Constructors
    public Salesman() {
       this.role = "salesman";
    }

    public Salesman(String username, String password, String email, String role) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
    }

    // Getters and Setters

    public Long getSalesmanId() {
        return salesmanId;
    }

    public void setSalesmanId(Long salesmanId) {
        this.salesmanId = salesmanId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }   

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setRole(String role) {
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    // Boilerplate

    @Override
    public int hashCode() {
        return (salesmanId != null ? salesmanId.hashCode() : 0);
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Salesman)) return false;
        Salesman other = (Salesman) obj;
        return (this.salesmanId != null || other.salesmanId == null) &&
               (this.salesmanId == null || this.salesmanId.equals(other.salesmanId));
    }

    @Override
    public String toString() {
        return "Salesman[ id=" + salesmanId + ", username=" + username + " ]";
    }
}

