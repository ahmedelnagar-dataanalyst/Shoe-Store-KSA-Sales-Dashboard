-- ============================================
-- Shoe Store KSA - MySQL Setup
-- Stage 1: Create Tables
-- ============================================

CREATE DATABASE IF NOT EXISTS shoestoreksa;
USE shoestoreksa;

-- Branches
CREATE TABLE branches (
    branch_id    INT PRIMARY KEY,
    branch_name  VARCHAR(100),
    city         VARCHAR(50),
    location     VARCHAR(255),
    manager_name VARCHAR(100)
);

-- Shoes
CREATE TABLE shoes (
    shoe_id  VARCHAR(10) PRIMARY KEY,
    category VARCHAR(50),
    color    VARCHAR(50),
    size     INT,
    price    DECIMAL(10,2)
);

-- Sales
CREATE TABLE sales (
    sale_id       INT PRIMARY KEY,
    branch_id     INT,
    shoe_id       VARCHAR(10),
    sale_date     DATE,
    quantity_sold INT,
    total_price   DECIMAL(10,2),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (shoe_id)   REFERENCES shoes(shoe_id)
);

-- Sales Targets
CREATE TABLE sales_targets (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    branch_id    INT,
    month        VARCHAR(20),
    sales_target DECIMAL(10,2),
    units_target INT,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
