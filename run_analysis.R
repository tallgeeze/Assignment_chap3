##########loading########
library(tidyr)
library(dplyr)

##########extracting data###########
#####################################
train_set <- read.table("train/X_train.txt")
train_label <- read.table("train/y_train.txt")
test_set <- read.table("test/X_test.txt")
test_label <- read.table("test/y_test.txt")
train_subject <-read.table("train/subject_train.txt")
test_subject <-read.table("test/subject_test.txt")
features <- read.table("features.txt", stringsAsFactors = F)


########merge####################
###############################
temp1<- cbind.data.frame(train_subject,train_label)
train_data <- cbind.data.frame(temp1, train_set)
temp2<- cbind.data.frame(test_subject, test_label)
test_data <- cbind.data.frame(temp2,test_set )

data_base <- rbind(train_data, test_data)
#####so far we have data frame with no name and filtering



########now giving names to data frame####
#####################################
name_list_1 <- c("subject" , "activity") 
name_list_2 <- features$V2
colnames(data_base) <-c(name_list_1, name_list_2)




##########replace the status code with activity names###########
#################################################################
data_base$activity <- gsub("1","WALKING",data_base$activity)
data_base$activity <- gsub("2","WALKING_UPSTAIRS",data_base$activity)
data_base$activity <- gsub("3","WALKING_DOWNSTAIRS",data_base$activity)
data_base$activity <- gsub("4","SITTING",data_base$activity)
data_base$activity <- gsub("5","STANDING",data_base$activity)
data_base$activity <- gsub("6","LAYING",data_base$activity)



#########now filtering means and stds##############
####################################################
means_and_stds <- grep(pattern = "mean|std",c(name_list_1, name_list_2) )
tidy_data <- data_base[,c(1,2,means_and_stds)] 




#########reshaping data& its name#########
View(tidy_data)   
write.table(tidy_data, file = "tidy_data.txt", row.names = F)



####                                               ####
#### tidy_data_set is the cleaned data set, which  ####   
#### contains subject, mean of sensor data at each ####
#### observation and its standard diviation        ####



######## thank you for your grading!     ##########
