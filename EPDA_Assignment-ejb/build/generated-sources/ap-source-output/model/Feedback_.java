package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Car;
import model.Customer;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-05-08T22:59:57")
@StaticMetamodel(Feedback.class)
public class Feedback_ { 

    public static volatile SingularAttribute<Feedback, Car> car;
    public static volatile SingularAttribute<Feedback, Double> rating;
    public static volatile SingularAttribute<Feedback, Long> feedbackId;
    public static volatile SingularAttribute<Feedback, String> comment;
    public static volatile SingularAttribute<Feedback, Date> submittedAt;
    public static volatile SingularAttribute<Feedback, Customer> customer;

}