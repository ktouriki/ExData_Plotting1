
library("sqldf")

sqldf("attach sample_db as new")

read.csv.sql(file="~/R programming/sample_data.csv", sql = "create table df as select * from file ", dbname = "sample_db", header = T, row.names = F, sep = ";")
df<-sqldf("select * from new where Date='1/2/2007' or Date='2/2/2007' ", dbname = "new_db")
datetime<-paste(as.character(df$Date), as.character(df$Time))
datetime<-strptime(datetime, "%d/ %m/ %Y %H: %M: %S")
df$datetime<-datetime

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
plot(df$datetime, df$Global_active_power, type="l", ylab="Global Active Power (kilowatts", xlab="")
plot(df$datetime, df$Voltage, type="l", ylab="Voltage", xlab="")
plot(df$datetime, df$Sub_metering_2, type='l', col="red", ylim=range(c(df$Sub_metering_1,df$Sub_metering_2,df$Sub_metering_3)), ylab="Energy Sub metering", xlab="")
par(new=TRUE)
plot(df$datetime, df$Sub_metering_3, type='l', col="blue", ylim=range(c(df$Sub_metering_1,df$Sub_metering_2,df$Sub_metering_3)), ylab="Energy Sub metering", xlab="")
par(new=TRUE)
plot(df$datetime, df$Sub_metering_1, type='l', col="black", ylim=range(c(df$Sub_metering_1,df$Sub_metering_2,df$Sub_metering_3)), ylab="Energy Sub metering", xlab="")
plot(df$datetime, df$Global_reactive_power, type="l", ylab="Global reactive power", xlab="")
dev.off()
