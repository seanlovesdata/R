install.packages("RODBC")
library("RODBC")

connection<-odbcConnect('med-sql01')

fund_v_bmk <-sqlQuery(connection, "select *
                          MED_EDW.edw.fund_vs_benchmark_comparison_mifl")


monthly_holdings_fact <-sqlQuery(connection, "select *
                          MED_EDW.edw.monthly_holdings_fact")



life_insurance_premium_details <-sqlQuery(connection, "select sum(AMOUNT)
                         from MED_EDW.edw.life_insurance_premium_details where CLIENT_ID=271094")

metrics_monthly_series <- sqlQuery(connection, "select [MonthKey], [FundClassCode], [BMK Performance]
                              from MED_EDW.edw.tbl_Metrics_Funds_Monthly_Series")

mms_beat_bmk <- sqlQuery(connection, "select [MonthKey], [FundClassCode], [BMK Performance], [NAV per Unit]
      ,[GAV per Unit]
      ,[BMK]
      ,[Net Performance]
      ,[Gross Performance]
      ,[BMK Performance]
      from MED_EDW.edw.tbl_Metrics_Funds_Monthly_Series
      where [BMK Performance] > 2")

mms_beat_bmk$[NAV per Unit]

'
exit()







