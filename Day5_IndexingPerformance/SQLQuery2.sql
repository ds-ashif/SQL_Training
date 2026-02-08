SET STATISTICS IO ON  --shows logical reads
SET STATISTICS TIME ON   --shows cpp/time

Use AdventureWorks2025
Go

select * into perf_issue from Person.person

insert into perf_issue

select * from Person.person

select * from perf_issue

create view perf_issue_vw
as
select * from perf_issue

select * from perf_issue_vw



