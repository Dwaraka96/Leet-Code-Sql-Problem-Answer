##Question: Find Median Given Frequency of Numbers (LeetCode 571)
##The goal of this problem is to calculate the median of a set of numbers when those numbers are provided in a table alongside their frequencies

Sample Input
The input is a table named numbers containing two columns: num and frequency

num    frequency
0        7
1        1
2        3
3        1
Logic for Calculation
To find the median, you must first understand the expanded list of numbers represented by this table

0 appears 7 times: (0, 0, 0, 0, 0, 0, 0)
1 appears 1 time: (1)
2 appears 3 times: (2, 2, 2)
3 appears 1 time: (3)

The total number of entries (Overall Count) is 12. Since 12 is an even number, the median is the average of the two middle values at the 6th and 7th positions.
The 6th value in the expanded sequence is 0.
The 7th value in the expanded sequence is 0.
Calculation: (0+0)/2=0

Sample Output
median
0.0
(Note: The output is typically formatted to one decimal position, resulting in 0.0)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  The SQL Solution  ##
WITH recursive CTE AS (
    -- Step 1: Base query to select initial data
    SELECT num, frequency, 1 AS CT 
    FROM numbers
    UNION ALL
    -- Recursive step to expand rows based on frequency
    SELECT num, frequency, CT + 1 AS CT 
    FROM CTE 
    WHERE CT < frequency
),
expanded_table AS (
    -- Step 2: Generate sequence numbers and total counts
    SELECT 
        num, 
        COUNT(*) OVER() AS overall_count, 
        ROW_NUMBER() OVER(ORDER BY num ASC) AS sequence 
    FROM CTE
),
flagged_median AS (
    -- Step 3: Identify the median row(s)
    SELECT num, 
    CASE 
        -- Logic for even total rows
        WHEN MOD(overall_count, 2) = 0 THEN 
            CASE WHEN sequence = FLOOR(overall_count / 2) 
                 OR sequence = FLOOR(overall_count / 2) + 1 THEN 'median' END
        -- Logic for odd total rows
        WHEN MOD(overall_count, 2) = 1 THEN 
            CASE WHEN sequence = FLOOR(overall_count / 2) + 1 THEN 'median' END
    END AS median_status
    FROM expanded_table
),
filtered_median AS (
    -- Step 4: Filter for the identified median rows
    SELECT num 
    FROM flagged_median 
    WHERE median_status = 'median'
)
-- Step 5: Calculate the final median (averaging if there are two rows)
SELECT 
    CASE 
        WHEN COUNT(*) = 1 THEN ROUND(SUM(num), 1)
        WHEN COUNT(*) = 2 THEN ROUND(SUM(num) / 2.0, 1)
    END AS median
FROM filtered_median;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Breakdown of the Answer:
Recursive CTE: This is used to transform the frequency table into a sequential list
. It repeatedly joins the table to itself, incrementing a counter (CT) until it matches the frequency value for each number
.
Window Functions: The COUNT(*) OVER() function provides the total number of entries in the expanded list, and ROW_NUMBER() OVER(ORDER BY num ASC) assigns a unique position to every number
.
Median Logic:
If the overall count is odd (MOD = 1), the median is at the position FLOOR(total/2) + 1
.
If the overall count is even (MOD = 0), the median is the average of the values at positions total/2 and (total/2) + 1
.
Final Calculation: A CASE statement determines whether to return the single number (for odd totals) or the average of two numbers (for even totals)
