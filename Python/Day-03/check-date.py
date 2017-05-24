#!/usr/bin/python
year=int(input("年份"))
month=int(input("月份:"))
day=int(input("日期"))
sum_ping=[31,28,31,30,31,30,31,31,30,31,30,31]
sum_run=[31,29,31,30,31,30,31,31,30,31,30,31]
yy,i=0,1
if year%4==0 and year%100!=0 or year%400==0:
	while i<month:
		yy=yy+sum_run[i]
		i+=1
else:
	while i<month:
                yy=yy+sum_ping[i]
                i+=1
dd=yy+day
print (month,"月",day,"日是本年第",dd,"天")
