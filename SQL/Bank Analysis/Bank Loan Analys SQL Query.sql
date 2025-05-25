
USE junaid;

select * from finance1 ;
select * from finance2 ;
select count(*) from finance1 ;
SHOW TABLES;

# KPI 1

select year (issue_D) as year_of_issue_d , sum(loan_amnt) as Total_Loan_amt
from finance1
group by year_of_issue_d
order by year_of_issue_d;

# KPI 2

select grade, sub_grade, sum(revol_bal) as Total_revol_bal
from finance1
inner join finance2 on (finance1.id = finance2.id)
group by grade, sub_grade
order by grade, sub_grade;


# KPI 3
select verification_status ,
concat("$", format(round(sum(total_pymnt)/1000000,2),2),"M") as total_payment

from finance1 inner join finance2
on (finance1.id = finance2.id)
group by verification_status ;



# KPI 4

select addr_state , last_Credit_pull_D , loan_status
from finance1 inner join finance2
on (finance1.id = finance2.id)
group by addr_state , last_Credit_pull_D , loan_status
order by last_Credit_pull_D ;



# KPI 5 

select
home_ownership,
last_pymnt_d,
       concat("$", format(round(sum(last_pymnt_amnt) / 10000, 2), 2), "K") as total_amount
from finance1
inner join finance2 on finance1.id = finance2.id
group by home_ownership, last_pymnt_d
order by  last_pymnt_d desc, home_ownership desc;

