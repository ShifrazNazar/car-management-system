/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

@Entity
@Table(name = "sale")
public class Sale implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long saleId;

    @ManyToOne
    @JoinColumn(name = "car_id", nullable = false)
    private Car car;

    @ManyToOne
    @JoinColumn(name = "salesman_id", nullable = false)
    private Salesman salesman;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @Column(nullable = false)
    private String status; // available / booked / paid / cancel

    @Column
    private double amountPaid;

    @Column(length = 1000)
    private String comment;

    @Column
    private boolean reviewed; // Flag to track if review has been submitted

    @Temporal(TemporalType.TIMESTAMP)
    private Date saleDate;

    // Constructors
    public Sale() {
        this.saleDate = new Date();
        this.status = "booked"; // default status when created
        this.reviewed = false; // default to not reviewed
    }

    public Sale(Car car, Salesman salesman, Customer customer, double amountPaid, String comment) {
        this.car = car;
        this.salesman = salesman;
        this.customer = customer;
        this.amountPaid = amountPaid;
        this.comment = comment;
        this.status = "paid";
        this.saleDate = new Date();
        this.reviewed = false;
    }

    // Getters and Setters

    public Long getSaleId() {
        return saleId;
    }

    public void setSaleId(Long saleId) {
        this.saleId = saleId;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public Salesman getSalesman() {
        return salesman;
    }

    public void setSalesman(Salesman salesman) {
        this.salesman = salesman;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getAmountPaid() {
        return amountPaid;
    }

    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public boolean isReviewed() {
        return reviewed;
    }

    public void setReviewed(boolean reviewed) {
        this.reviewed = reviewed;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    // Boilerplate

    @Override
    public int hashCode() {
        return (saleId != null ? saleId.hashCode() : 0);
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Sale)) return false;
        Sale other = (Sale) obj;
        return (this.saleId != null || other.saleId == null) &&
               (this.saleId == null || this.saleId.equals(other.saleId));
    }

    @Override
    public String toString() {
        return "Sale[ id=" + saleId + ", status=" + status + ", paid=" + amountPaid + " ]";
    }
}
