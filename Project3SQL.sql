create database project3_sql

select * from [dbo].[blood-banks]




select blood_bank_name, Nodal_Officer, state, city, qualification_nodal_officer
from [blood-banks]
where Qualification_Nodal_Officer like '%MBBS%' and Blood_Component_Available = 'Yes';


SELECT AVG(num_blood_banks) AS avg_blood_banks
FROM (
    SELECT state, COUNT(*) AS num_blood_banks
    FROM [blood-banks]
    WHERE service_time = '24X7'
    GROUP BY state
) AS state_blood_banks;


-- 1. total no. of Blood banks.

Select COUNT(*) as No_of_Blood_banks
from [blood-banks]

--2. State-wise no. of blood banks in India.

select state, 
	COUNT(*) as state_wise_count
from [blood-banks]
group by State
order by state_wise_count desc;

-- 3. Availability of apheresis facility.

select state,
COUNT(*) as Apheresis_wise_count
from [blood-banks]
where Apheresis = 'yes'
group by State
order by Apheresis_wise_count desc;

-- 4. 24/7 available blood banks.

select state, COUNT(*) as Service_time_count
from [blood-banks]
where Service_Time like '%24%'
group by State
order by Service_time_count desc;

-- 5. Category wise blood banks- Govt. & Charity.

select state, COUNT(*) as Category_count
from [blood-banks]
where Category in ('Goverment', 'Charity')
group by State
order by Category_count desc;

-- 6. Blood component availability - blood banks.

select state, COUNT(blood_component_available) as blood_comp_avl_count
from [blood-banks]
where Blood_Component_Available = 'Yes'
group by State
order by blood_comp_avl_count desc;

-- 7. No. of licensed blood banks.

select state ,count(*) as license_avb_count from [blood-banks] 
where license  != ''
group by state 
order by  license_avb_count desc

-- 8. Creating case-fully functional blood banks.

select blood_bank_name, city, pincode, mobile,
case when Blood_Component_Available ='yes'and apheresis ='yes'and 
service_time like '%24%' 
then 'totally functional' 
else ' partially functional' 
end as 'functionality status ' 
from [blood-banks] 
where License != '' and state = 'gujarat'

--9. States having no of blood banks less than 30.

select state , count(*) as less_than_30_blood_bank from [blood-banks] 
group by State 
having count(*)<30;

--10. Find the blood banks that have been operational for the longest time:
SELECT TOP 20
    blood_bank_name,
    state,
    city,
    DATEDIFF(day, CONVERT(DATE, date_license_obtained, 104), GETDATE()) AS operational_days
FROM [blood-banks]


--11. List blood banks where the nodal officer's qualification is 'MBBS' and they have blood component separation available:

SELECT blood_bank_name, state, city, qualification_nodal_officer
FROM [blood-banks]
WHERE qualification_nodal_officer LIKE '%MBBS%' AND blood_component_available = 'YES';

--12. Identify the top 5 districts with the highest density of blood banks, normalized by the number of cities in the district:

SELECT top 5 district, COUNT(*) / COUNT(DISTINCT city) as density
FROM [blood-banks]
GROUP BY district
ORDER BY density DESC;


--13. Find the most common qualifications of nodal officers in blood banks:

SELECT qualification_nodal_officer, COUNT(*) as num_nodal_officers
FROM [blood-banks]
where Qualification_Nodal_Officer is not null
GROUP BY qualification_nodal_officer
ORDER BY num_nodal_officers DESC;

--14. Count the number of blood banks per state and categorize them based on whether they offer apheresis services or not:

SELECT state,
       SUM(CASE WHEN apheresis = 'YES' THEN 1 ELSE 0 END) as apheresis_banks,
       SUM(CASE WHEN apheresis = 'NO' THEN 1 ELSE 0 END) as non_apheresis_banks
FROM [blood-banks]
GROUP BY state;


--15. 

