-- 1. Get all city-level sales with proper country/state/city breakdown
WITH city_sales AS (
    SELECT 
        t2.Country, 
        t2.State, 
        t2.City, 
        t1.Sales
    FROM 
        inputtable2 t2
        JOIN inputtable1 t1 ON t2.City = t1.Market
),

-- 2. Sum up city sales for each state (to be used for state-level leftover calculation)
state_group_sales AS (
    SELECT 
        country, 
        state, 
        SUM(sales) AS sales
    FROM 
        city_sales
    GROUP BY 
        country, state
),

-- 3. Get state-level sales whether or not they exist (ensures all states from hierarchy included)
state_sales AS (
    SELECT DISTINCT 
        t2.Country, 
        t2.State, 
        NULL AS city, 
        IFNULL(t1.Sales, 0) AS sales
    FROM 
        inputtable1 t1
        RIGHT JOIN inputtable2 t2 ON t1.Market = t2.State
),

-- 4. Combine:
--    a) state-level leftovers (state sales minus their cities' sales, only if not zero)
--    b) all recognized city-level sales
state_and_city_sales AS (
    -- a) state-level leftovers
    SELECT 
        ss.Country, 
        ss.State, 
        ss.City, 
        ss.sales - IFNULL(sgs.sales, 0) AS sales
    FROM 
        state_sales ss
        LEFT JOIN state_group_sales sgs 
            ON ss.State = sgs.State
    WHERE 
        (ss.sales - IFNULL(sgs.sales, 0)) != 0

    UNION

    -- b) all city-level sales (most granular)
    SELECT 
        * 
    FROM 
        city_sales
),

-- 5. Calculate the total distributed sales for each country
country_sale AS (
    SELECT 
        country, 
        SUM(sales) AS sales
    FROM 
        state_and_city_sales
    GROUP BY 
        country
)

-- 6. Final Output:
--    Include all city and state-level sales, then add country-level leftovers, if any.
SELECT 
    *
FROM 
    state_and_city_sales

UNION

-- Calculate country-level leftover: (inputtable1's 'country' row) - (sum of all distributed sales)
SELECT 
    cs.country, 
    NULL AS state, 
    NULL AS city, 
    t1.sales - cs.sales AS sales
FROM 
    inputtable1 t1
    JOIN country_sale cs ON t1.market = cs.country
WHERE 
    (t1.sales - cs.sales) != 0  -- only include if there's a leftover
;