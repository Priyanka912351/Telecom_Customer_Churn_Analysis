USE shivansh_firm;
select*from telecommunication_churn_analysis;
DESCRIBE telecommunication_churn_analysis;

#How many total customers do we have?
SELECT COUNT(*) AS TotalCustomers FROM telecommunication_churn_analysis;

#How many customers have churned?
SELECT COUNT(*) AS Churned_Customers FROM telecommunication_churn_analysis WHERE Customer_Status = 'Churned';

#How many customers are still active?
SELECT COUNT(*) AS Churned_Customers FROM telecommunication_churn_analysis WHERE Customer_Status = 'Stayed';

#How many customers joined recently?
SELECT COUNT(*) AS Churned_Customers FROM telecommunication_churn_analysis WHERE Customer_Status = 'Joined';

#What percentage of customers have churned?
SELECT ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telecommunication_churn_analysis), 2) AS ChurnRate FROM telecommunication_churn_analysis WHERE Customer_Status = 'Churned';

#What is the average monthly charge per customer?
SELECT ROUND(AVG(Monthly_Charge), 2) AS AvgMonthlyCharge FROM telecommunication_churn_analysis;

#What is the average CLTV?
SELECT ROUND(AVG(CLTV), 2) AS AvgCLTV FROM telecommunication_churn_analysis;

#What is the total revenue from all customers?
SELECT SUM(Total_Revenue) AS TotalRevenue FROM telecommunication_churn_analysis;

#How much revenue is lost from churned customers?
SELECT SUM(Total_Revenue) AS RevenueLost FROM telecommunication_churn_analysis WHERE Customer_Status = 'Churned';

#How long do customers stay on average?
SELECT ROUND(AVG(Tenure_in_Months), 1) AS AvgTenureMonths FROM telecommunication_churn_analysis;

#How satisfied are customers on average?
SELECT ROUND(AVG(Satisfaction_Score), 1) AS AvgSatisfactionScore FROM telecommunication_churn_analysis;

#1)Count total customers by churn status
SELECT Churn, COUNT(*) AS TotalCustomers FROM telecommunication_churn_analysis GROUP BY Churn;

#2)Average monthly charge by contract type
SELECT Contract, AVG(Monthly_Charge) AS AvgMonthlyCharge FROM telecommunication_churn_analysis GROUP BY Contract;

#3)Total revenue by gender
SELECT Gender, ROUND (SUM(Total_Revenue),0) AS TotalRevenue FROM telecommunication_churn_analysis GROUP BY Gender;

#4)Average CLTV by internet service
SELECT Internet_Service, ROUND(AVG(CLTV),0) AS AvgCLTV FROM telecommunication_churn_analysis GROUP BY Internet_Service;

#5)Count of customers by CITY, ordered by number of customers
SELECT City, COUNT(*) AS TotalCustomers FROM telecommunication_churn_analysis GROUP BY City ORDER BY TotalCustomers DESC;

#6)Identify high-risk customers for churn
#Which customers are most likely to churn, and what is their profile?
SELECT Customer_ID, Customer_Status, Churn_Score, CLTV, Age, Gender, Tenure_In_Months, Contract, Monthly_Charge FROM telecommunication_churn_analysis WHERE Customer_Status = 'Stayed' ORDER BY Churn_Score DESC;

#7) Churn rate by contract type
#Which contract type has the highest churn rate?
SELECT Contract, 
       COUNT(*) AS Total_Customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
       ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100, 2) AS Churn_Rate_Percent
FROM telecommunication_churn_analysis
GROUP BY Contract
ORDER BY Churn_Rate_Percent DESC;

#8)Revenue analysis by customer segment
#Which age group or demographic contributes most to monthly revenue?
SELECT Age, Gender, SUM(Monthly_Charge) AS Total_Monthly_Revenue, AVG(Monthly_Charge) AS Avg_Monthly_Revenue
FROM telecommunication_churn_analysis
GROUP BY Age, Gender
ORDER BY Total_Monthly_Revenue DESC;

#9)Average data usage by contract type
#Do higher-tier contracts result in higher data usage?
SELECT Contract, AVG(Avg_Monthly_GB_Download) AS Avg_Data_Usage_GB
FROM telecommunication_churn_analysis
GROUP BY Contract
ORDER BY Avg_Data_Usage_GB DESC;

#10)Regional churn hotspots
#Which cities or states have the highest churn, and which are top CLTV contributors?
SELECT City, COUNT(*) AS Total_Customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
       ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100, 2) AS Churn_Rate_Percent,
       AVG(CLTV) AS Avg_CLTV
FROM telecommunication_churn_analysis
GROUP BY City
ORDER BY Churn_Rate_Percent DESC;
