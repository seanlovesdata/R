
install.packages("XLConnect", dependencies=TRUE)

# import package
require(XLConnect)
require(quantmod)
require(MFTSR)
# load workbook
wb = XLConnect::loadWorkbook('C:/Users/sean.mcnally/Documents/testxls.xlsx')

# switch to correct sheet
sheet = readWorksheet(wb,1)


# last 200 rows for calculation, for you this will be something like sheet$pvar to select the pvar column
x <- tail(sheet, n=20)

# EMA: I need data to test this but there are 4 or 5 libraries or functions that would do this for you, some allow you specify
# lambda as a decimal while some use a formula,
# n is number of periods to average over
# Wilder = true will use exponential smoothing ratio of 1/n 
# wilder = false uses exponential smoothing of 2/n+1 
# pvarEMA <- EMA(tail, n=200, wilder = FALSE, ratio)


# write results to xls file
writeWorksheetToFile('C:/Users/sean.mcnally/Documents/pvaroutput.xlsx', data=sheet, sheet="FirstSheet", styleAction = XLC$STYLE_ACTION.XLCONNECT)


