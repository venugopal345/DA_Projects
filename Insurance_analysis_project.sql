use insurance_project;

-- -----------------------------------All KPIS-------------------------------------------------------

-- kpi-1: Total Policy
select count(distinct policyid) as total_policy
from policy;
-- Active count
select count(distinct policyid) as total_policy
from policy
where status="active";
-- Lapsed(expired) count
select count(distinct policyid) as total_policy
from policy
where status="Lapsed";
-- Terminated count
select count(distinct policyid) as total_policy
from policy
where status="terminated";

-- KPI-2 Total Customers

select count(distinct customerid) as total_customers
from customer;

-- same count
select count(distinct policyid) as total_policy, count(Customerid) as total_customers
from policy;

-- KPI-3 : Age bucket wise policy count

select  c.AgeGroup,count(distinct p.policyid) as policy
from policy as p join customer as c
on p.customerid = c.customerid
group by c.AgeGroup;

-- KPI-4 : Gender Wise Policy count

select c.gender, count(distinct p.policyid) as policy
from policy as p join customer as c
on p.customerid = c.customerid
group by c.gender;

-- KPI-5 : Policy Type Wise Policy Count

select policytype, count(distinct policyid) as policy
from policy
group by policytype;

-- KPI-6 : Policy Expire This Year
select enddate, count(*) as policy
from policy
where enddate = 2026 
group by enddate;

select enddate, count(*) as policy
from policy
where enddate = 2026 and status="active"
group by enddate;

-- KPI-7 : Premium Growth Rate(year wise)

select startdate, round(sum(premiumamount),2) as total_premium, 
concat(round((sum(premiumamount)- lag(sum(premiumamount)) over(order by startdate))
/ lag(sum(premiumamount)) over(order by startdate)*100,0)," %") as growth_rate
from policy
group by startdate
order by startdate;

-- KPI-8 : Claim Status Wise Policy Count

select claimstatus, count(*) as policy_count
from claim
group by claimstatus;

-- KPI-9 : Payment Status Wise Policy Count

select paymentstatus, count(*) as policy_count
from payment
group by paymentstatus;

-- KPI-10 : Total Claim Amount

select concat(sum(claimamount)," M") as total_claim
from claim;
