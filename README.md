# 🛍️ Meesho Orders SQL Analysis  

This project demonstrates how to design a relational database in PostgreSQL using **real-world e-commerce order data (Meesho Orders - August)** and perform insightful SQL queries.  

## 📂 Dataset
The dataset contains order-level details such as:
- Sub Order Number  
- Order Date  
- Customer State  
- Product Name  
- SKU & Size  
- Quantity  
- Supplier Listed Price  
- Supplier Discounted Price  
- Reason for Credit Entry  

## 🏗️ Database Schema
```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    sub_order_no              VARCHAR(50),
    reason_for_credit_entry   VARCHAR(50),
    order_date                DATE,
    customer_state            VARCHAR(100),
    product_name              TEXT,
    sku                       VARCHAR(100),
    size                      VARCHAR(50),
    quantity                  INT,
    supplier_listed_price     DECIMAL(10,2),
    supplier_discounted_price DECIMAL(10,2)
);
