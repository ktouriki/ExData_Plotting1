library("sqldf")

sqldf("attach sample_db as new")

read.csv.sql(file="~/R programming/sample_data.csv", sql = "create table df as select * from file ", dbname = "sample_db", header = T, row.names = F, sep = ";")
df<-sqldf("select * from new where Date='1/2/2007' or Date='2/2/2007' ", dbname = "new_db")
datetime<-paste(as.character(df$Date), as.character(df$Time))
datetime<-strptime(datetime, "%d/ %m/ %Y %H: %M: %S")
df$datetime<-datetime

png("plot2.png", width=480, height=480)
plot(df$datetime, df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()