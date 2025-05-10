# Car Sales System

A web-based Car Sales System for automotive companies with three user interfaces: Managing Staff, Salesmen, and Customers.

## Features

### Managing Staff

- Staff management (add, delete, search, update)
- Salesmen and customer management
- Car inventory management
- Payment & feedback analysis
- Reporting system

### Salesmen

- Profile management
- Car status tracking
- Sales management
- Payment collection
- Sales records

### Customers

- Profile management
- Purchase feedback
- Purchase history
- Rating system

## Technical Stack

- Java EE 7
- Java 8
- GlassFish Server
- Java DB
- PrimeFaces
- NetBeans 8.2

## Project Structure

```
EPDA_Assignment/
├── EPDA_Assignment-ejb/     # Business logic
│   └── src/
│       └── java/model/      # Entity classes
│           ├── Car.java
│           ├── Customer.java
│           ├── Feedback.java
│           ├── ManagingStaff.java
│           ├── Sale.java
│           └── Salesman.java
│
├── EPDA_Assignment-war/     # Web interface
│   └── web/
│       ├── customer/        # Customer interface
│       ├── manager/         # Manager interface
│       ├── salesman/        # Salesman interface
│       ├── login.jsp
│       └── register.jsp
│
└── build.xml               # Build configuration
```

## Setup

1. **Prerequisites**

   - JDK 8 update 45
   - NetBeans 8.2
   - GlassFish Server
   - Java DB

2. **Build & Run**

   ```bash
   # Using NetBeans
   - Open project in NetBeans 8.2
   - Clean and Build
   - Deploy to GlassFish

   # Using Ant
   ant clean
   ant build
   ```

## Development

- Follow Java EE 7 specifications
- Use PrimeFaces for UI components
- Implement proper security measures
- Test thoroughly before deployment

## License

[Add your license information here]
