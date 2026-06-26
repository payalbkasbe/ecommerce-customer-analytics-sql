# e-Commerce Customer Analytics Project

## Project Overview
This project simulates a real-world relational database for an e-commerce platform. Using MySQL, I designed a 4-table relational schema, generated mock data, and executed intermediate to advanced SQL queries to uncover critical business insights regarding customer lifetime value, product category performance, and customer retention metrics.

## Relational Schema Design
The database consists of the following interconnected tables:
* **users**: Customer profile information (Primary Key: `user_id`)
* **products**: Inventory item details and pricing (Primary Key: `product_id`)
* **orders**: Transaction tracking (Primary Key: `order_id`, Foreign Key: `user_id`)
* **order_items**: Line-item breakdown linking orders to specific products (Primary Key: `item_id`)

## Key Business Insights & Queries
1. **Customer Lifetime Value (LTV):** Identified top-spending customers by combining data across all four tables. Learned that low-frequency, high-ticket purchasers (e.g., furniture shoppers) can out-value high-frequency, low-ticket buyers.
2. **Category Performance:** Screened product categories generating more than $100 in revenue using the `HAVING` clause, isolating Electronics and Furniture as primary revenue drivers.
3. **Retention Analysis:** Utilized advanced Window Functions (`LAG()`) to calculate the exact timelines between consecutive customer purchases, revealing an average repeat-purchase gap of 73 days for active cohorts.

## Tools Used
* **Database Engine:** MySQL
* **IDE:** MySQL Workbench
