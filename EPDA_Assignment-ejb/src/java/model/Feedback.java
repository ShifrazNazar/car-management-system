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
@Table(name = "feedback")
public class Feedback implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long feedbackId;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "car_id", nullable = false)
    private Car car;

    @Column(length = 1000)
    private String comment;

    @Column
    private double rating; // 1.0 to 5.0 scale

    @Temporal(TemporalType.TIMESTAMP)
    private Date submittedAt;

    // Constructors
    public Feedback() {
        this.submittedAt = new Date();
    }

    public Feedback(Customer customer, Car car, String comment, double rating) {
        this.customer = customer;
        this.car = car;
        this.comment = comment;
        this.rating = rating;
        this.submittedAt = new Date();
    }

    // Getters and Setters

    public Long getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(Long feedbackId) {
        this.feedbackId = feedbackId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public Date getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Date submittedAt) {
        this.submittedAt = submittedAt;
    }

    // Boilerplate

    @Override
    public int hashCode() {
        return (feedbackId != null ? feedbackId.hashCode() : 0);
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Feedback)) return false;
        Feedback other = (Feedback) obj;
        return (this.feedbackId != null || other.feedbackId == null) &&
               (this.feedbackId == null || this.feedbackId.equals(other.feedbackId));
    }

    @Override
    public String toString() {
        return "Feedback[ id=" + feedbackId + ", rating=" + rating + " ]";
    }
}
