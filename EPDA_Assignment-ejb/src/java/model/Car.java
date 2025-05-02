/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name = "car")
public class Car implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long carId;

    @Column(nullable = false)
    private String make;

    @Column(nullable = false)
    private String model;

    @Column(nullable = false)
    private String color;

    @Column(nullable = false)
    private double price;

    @Column(nullable = false)
    private String status; // available, booked, paid, cancel

    @ManyToOne
    @JoinColumn(name = "salesman_id")
    private Salesman salesman;

    // Constructors
    public Car() {}

    public Car(String make, String model, String color, double price, String status) {
        this.make = make;
        this.model = model;
        this.color = color;
        this.price = price;
        this.status = status;
    }

    // Getters and Setters

    public Long getCarId() {
        return carId;
    }

    public void setCarId(Long carId) {
        this.carId = carId;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Salesman getSalesman() {
        return salesman;
    }

    public void setSalesman(Salesman salesman) {
        this.salesman = salesman;
    }

    // Boilerplate

    @Override
    public int hashCode() {
        return (carId != null ? carId.hashCode() : 0);
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Car)) return false;
        Car other = (Car) object;
        return (this.carId != null || other.carId == null) && (this.carId == null || this.carId.equals(other.carId));
    }

    @Override
    public String toString() {
        return "Car[ id=" + carId + ", model=" + make + " " + model + " ]";
    }
}

