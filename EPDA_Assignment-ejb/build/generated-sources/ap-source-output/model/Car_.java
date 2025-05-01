package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Salesman;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-05-01T02:57:29")
@StaticMetamodel(Car.class)
public class Car_ { 

    public static volatile SingularAttribute<Car, String> color;
    public static volatile SingularAttribute<Car, String> year;
    public static volatile SingularAttribute<Car, Double> price;
    public static volatile SingularAttribute<Car, String> model;
    public static volatile SingularAttribute<Car, Salesman> salesman;
    public static volatile SingularAttribute<Car, String> make;
    public static volatile SingularAttribute<Car, Long> carId;
    public static volatile SingularAttribute<Car, String> status;

}