-- ============================================
-- Shoe Store KSA - MySQL
-- Stage 2: Analysis Views
-- ============================================

USE shoestoreksa;

-- ----------------------------------------
-- View 1: Sales Performance by Branch
-- ----------------------------------------
CREATE OR REPLACE VIEW vw_branch_performance AS
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.manager_name,
    YEAR(s.sale_date)                          AS sale_year,
    MONTH(s.sale_date)                         AS sale_month,
    MONTHNAME(s.sale_date)                     AS month_name,
    COUNT(s.sale_id)                           AS total_orders,
    SUM(s.quantity_sold)                       AS total_units_sold,
    SUM(s.total_price)                         AS total_revenue,
    AVG(s.total_price)                         AS avg_order_value
FROM sales s
JOIN branches b ON s.branch_id = b.branch_id
GROUP BY
    b.branch_id, b.branch_name, b.city, b.manager_name,
    YEAR(s.sale_date), MONTH(s.sale_date), MONTHNAME(s.sale_date);

-- ----------------------------------------
-- View 2: Sales vs Target by Branch
-- ----------------------------------------
CREATE OR REPLACE VIEW vw_sales_vs_target AS
SELECT
    b.branch_name,
    b.city,
    t.month,
    t.sales_target,
    t.units_target,
    IFNULL(SUM(s.total_price), 0)              AS actual_sales,
    IFNULL(SUM(s.quantity_sold), 0)            AS actual_units,
    IFNULL(SUM(s.total_price), 0)
        - t.sales_target                       AS sales_variance,
    ROUND(
        IFNULL(SUM(s.total_price), 0)
        / NULLIF(t.sales_target, 0) * 100, 2
    )                                          AS achievement_pct
FROM sales_targets t
JOIN branches b ON t.branch_id = b.branch_id
LEFT JOIN sales s
    ON s.branch_id = t.branch_id
    AND MONTHNAME(s.sale_date) = t.month
GROUP BY
    b.branch_name, b.city, t.month,
    t.sales_target, t.units_target;

-- ----------------------------------------
-- View 3: Product Performance
-- ----------------------------------------
CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    sh.shoe_id,
    sh.category,
    sh.color,
    sh.size,
    sh.price,
    b.city,
    COUNT(s.sale_id)          AS total_orders,
    SUM(s.quantity_sold)      AS total_units_sold,
    SUM(s.total_price)        AS total_revenue,
    ROUND(
        SUM(s.total_price) * 100.0
        / (SELECT SUM(total_price) FROM sales), 2
    )                         AS revenue_share_pct
FROM sales s
JOIN shoes sh ON s.shoe_id = sh.shoe_id
JOIN branches b ON s.branch_id = b.branch_id
GROUP BY
    sh.shoe_id, sh.category, sh.color,
    sh.size, sh.price, b.city;

-- ----------------------------------------
-- View 4: Monthly Sales Trend
-- ----------------------------------------
CREATE OR REPLACE VIEW vw_monthly_trend AS
SELECT
    MONTH(s.sale_date)            AS month_num,
    MONTHNAME(s.sale_date)        AS month_name,
    b.branch_name,
    b.city,
    SUM(s.total_price)            AS total_revenue,
    SUM(s.quantity_sold)          AS total_units,
    COUNT(s.sale_id)              AS total_orders,
    AVG(s.total_price)            AS avg_order_value
FROM sales s
JOIN branches b ON s.branch_id = b.branch_id
GROUP BY
    MONTH(s.sale_date), MONTHNAME(s.sale_date),
    b.branch_name, b.city;

-- ----------------------------------------
-- View 5: Top Products by Category & City
-- ----------------------------------------
CREATE OR REPLACE VIEW vw_top_products AS
SELECT
    sh.category,
    b.city,
    sh.color,
    SUM(s.quantity_sold)   AS total_units_sold,
    SUM(s.total_price)     AS total_revenue,
    RANK() OVER (
        PARTITION BY sh.category, b.city
        ORDER BY SUM(s.total_price) DESC
    )                      AS revenue_rank
FROM sales s
JOIN shoes sh ON s.shoe_id = sh.shoe_id
JOIN branches b ON s.branch_id = b.branch_id
GROUP BY
    sh.category, b.city, sh.color;
