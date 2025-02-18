#######################################################################
####                  Data Exploration                             ####
#######################################################################

library(data.table)
library(ggplot2)

# function to provide simple display of time series
my_line_gplot <- function(dt, x_var, y_var) {
  ggplot(dt, aes(x=get(x_var), y=get(y_var))) + 
    geom_line(color="skyblue2", linewidth=2) + theme_minimal() + ylab(y_var) + 
    ylim(c(0, NA)) + ggtitle(y_var) + xlab(x_var)
}


#######################################################################
#####           hm10.xlsx     -     housing data
# load the Data
dt <- as.data.table(openxlsx::read.xlsx("data/hm10.xlsx", sheet = "Data"))
# remove garbage headers
dt <- dt[5:.N] 
# set column names properly
names(dt)[1] <- "date"
names(dt) <- gsub(".", "_", tolower(names(dt)), fixed = T)

# Convert all columns to appropriate types
dt <- dt[, lapply(.SD, type.convert, as.is = TRUE)]

# fix date issues
dt[, date := as.Date(as.integer(date), origin = "1899-12-30")]

my_line_gplot(dt, x_var="date", y_var=names(dt)[2])
my_line_gplot(dt, x_var="date", y_var=names(dt)[3])
my_line_gplot(dt, x_var="date", y_var=names(dt)[4])
my_line_gplot(dt, x_var="date", y_var=names(dt)[5])


#######################################################################
#####           hm5.xlsx     -     GDP
# load the Data
dt <- as.data.table(openxlsx::read.xlsx("data/hm5.xlsx", sheet = "Data"))
# remove garbage 
dt <- dt[5:.N]
dt <- dt[, c(1, 6, 7)] # (manual identification of relevant column...)

# set column names
names(dt)[1] <- "date"
names(dt)[3] <- paste0(names(dt)[3], "_sa") # seasonally adjusted
names(dt) <- gsub(".", "_", tolower(names(dt)), fixed = T)

# Convert all columns to appropriate types
dt <- dt[, lapply(.SD, type.convert, as.is = TRUE)]

# fix date issues
dt[, date := as.Date(as.integer(date), origin = "1899-12-30")]


my_line_gplot(dt, x_var="date", y_var=names(dt)[2])
my_line_gplot(dt, x_var="date", y_var=names(dt)[3])
