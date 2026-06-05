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
