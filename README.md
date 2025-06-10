# 🚀 Hierarchical Market Sales Aggregation

## 📦 Overview

This problem demonstrates how to process and flatten hierarchical sales data using SQL. The provided solution supports aggregating sales from multiple levels in a market hierarchy (Country → State → City), and can generate either a simplified or sophisticated output as required.

---

## 🚀 Problem Statement

Given two tables:

- **Input Table 1 (Market Sales):** Lists market names with their total sales value. These can represent the country, state, or city level.
- **Input Table 2 (Market Hierarchy):** Shows the hierarchical relationships of markets in three columns: Country, State, and City.

> **Goal:** Write an SQL query to produce a final, flattened table that:
> - Assigns sales to the lowest (most granular) level possible with residual sales reflected at parent levels, ready for aggregation at any level.
> - Provides either a simplified output (direct residuals) or a sophisticated output (with "Rest of X" labels for unallocated sales).

---

## 🗂️ Sample Data

### ➡️ Market Sales (`input_table_1`)

| Market       | Sales |
|--------------|-------|
| India        | 100   |
| Maharashtra  | 20    |
| Telangana    | 18    |
| Karnataka    | 22    |
| Gujarat      | 25    |
| Delhi        | 12    |
| Nagpur       | 8     |
| Mumbai       | 10    |
| Agra         | 5     |
| Hyderabad    | 9     |
| Bengaluru    | 12    |
| Hubli        | 12    |
| Bhopal       | 5     |

### ➡️ Market Hierarchy (`input_table_2`)

| Country | State       | City      |
|---------|-------------|-----------|
| India   | Maharashtra | Nagpur    |
| India   | Maharashtra | Mumbai    |
| India   | Maharashtra | Akola     |
| India   | Telangana   | Hyderabad |
| India   | Karnataka   | Bengaluru |
| India   | Karnataka   | Hubli     |
| India   | Gujarat     | Ahmedabad |
| India   | Gujarat     | Vadodara  |
| India   | UP          | Agra      |
| India   | UP          | Mirzapur  |
| India   | Delhi       |           |
| India   | Orissa      |           |

---

## 🎯 Expected Outputs

### 🌱 1. Simplified Output

| Country | State       | City      | Sales |
|---------|-------------|-----------|-------|
| India   | Maharashtra | Nagpur    | 8     |
| India   | Maharashtra | Mumbai    | 10    |
| India   | Maharashtra |           | 2     |
| India   | Telangana   | Hyderabad | 9     |
| India   | Telangana   |           | 9     |
| India   | Karnataka   | Bengaluru | 12    |
| India   | Karnataka   | Hubli     | 12    |
| India   | Karnataka   |           | -2    |
| India   | Gujarat     |           | 25    |
| India   | UP          | Agra      | 5     |
| India   | UP          |           | -5    |
| India   | Delhi       |           | 12    |
| India   |             |           | 3     |

### 🌳 2. Sophisticated Output

| Country | State       | City                | Sales |
|---------|-------------|---------------------|-------|
| India   | Maharashtra | Nagpur              | 8     |
| India   | Maharashtra | Mumbai              | 10    |
| India   | Maharashtra | Rest of Maharashtra | 2     |
| India   | Telangana   | Hyderabad           | 9     |
| India   | Telangana   | Rest of Telangana   | 9     |
| India   | Karnataka   | Bengaluru           | 12    |
| India   | Karnataka   | Hubli               | 12    |
| India   | Karnataka   | Rest of Karnataka   | -2    |
| India   | Gujarat     | Entire Gujarat      | 25    |
| India   | UP          | Agra                | 5     |
| India   | UP          | Rest of UP          | -5    |
| India   | Delhi       | Entire Delhi        | 12    |
| India   |             | Rest of India       | 3     |

---

## 🦾 Approach (Simplified Output, Step-by-Step)
Extract city-level sales:
Match cities in the hierarchy with city-level sales from the sales table.

Calculate state-level residuals:
For each state, subtract the sum of its city sales from the total state sales to get leftover state sales.

Combine city and state data:
List all city sales and all non-zero state-level residuals.

Calculate country-level residuals:
For each country, subtract the sum of all its state and city sales from the total country sales to get any leftover country sales.

Prepare the final output:
Combine all city sales, state residuals, and country residuals into one flat table for easy aggregation.

----
## 📁  Directory Structure

| File/Directory             | Description                                                   |
|---------------------------|----------------------------------------------------------------|
| `README.md`               | Project instructions (this file)                               |
Assets
| `image_of_Problem.jpg`    | Image of the Problem                                           |
Code
| `input.sql`               | SQL to crate input table     s                                 |
| `simplified_output.sql`   | SQL query for simplified output                                |
| `sophisticated_output.sql`| SQL query for sophisticated output                             |

---

## 🤔 Notes

- This project is generic and easily extensible to other hierarchical sales structures.
- Adjust input tables and logic for more levels or complex geography as needed.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 👨‍💻 Author

Asif Khan Mohammed.

linkedIN: [Link Text](https://www.linkedin.com/in/asif-khan-mohammed-aksi/).
email: [Link Text](asif.md1805@gmail.com).
github: [Link Text](https://github.com/asifkhan1805).

---

