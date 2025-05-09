package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Car;
import model.Customer;
import model.Salesman;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-05-08T21:13:24")
@StaticMetamodel(Sale.class)
public class Sale_ { 

    public static volatile SingularAttribute<Sale, Long> saleId;
    public static volatile SingularAttribute<Sale, Double> amountPaid;
    public static volatile SingularAttribute<Sale, Car> car;
    public static volatile SingularAttribute<Sale, Boolean> reviewed;
    public static volatile SingularAttribute<Sale, Salesman> salesman;
    public static volatile SingularAttribute<Sale, String> comment;
    public static volatile SingularAttribute<Sale, Date> saleDate;
    public static volatile SingularAttribute<Sale, Customer> customer;
    public static volatile SingularAttribute<Sale, String> status;

}