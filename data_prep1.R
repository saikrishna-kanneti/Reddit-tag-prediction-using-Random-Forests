
rm(list = ls(all = T))
library(stringi)
library(stringr)



#science space data. 
source_directory = paste(as.character(getwd()), "/20_newsgroup/sci.space", sep="")
all_files = list.files(path = source_directory, full.names = T)

dataset_list = c()
stringlen = c()
for(i in 1:length(all_files)){
  current_list = readLines(all_files[i])
  current_string = ""
  for(j in 15:length(current_list)){
    current_string = paste(current_string, current_list[j], sep = " ")
  }
  current_string = trimws(current_string)
  dataset_list = append(dataset_list, current_string)
  stringlen = append(stringlen, str_count(current_string, " "))
}

science_space_data = data.frame(dataset_list, stringlen)
science_space_data = science_space_data[which(science_space_data$stringlen > 150),]





source_directory = paste(as.character(getwd()), "/20_newsgroup/sci.med", sep="")
all_files = list.files(path = source_directory, full.names = T)

dataset_list = c()
stringlen = c()
for(i in 1:length(all_files)){
  current_list = readLines(all_files[i])
  current_string = ""
  for(j in 15:length(current_list)){
    current_string = paste(current_string, current_list[j], sep = " ")
  }
  current_string = trimws(current_string)
  dataset_list = append(dataset_list, current_string)
  stringlen = append(stringlen, str_count(current_string, " "))
}

science_medicine_data = data.frame(dataset_list, stringlen)
science_medicine_data = science_medicine_data[which(science_medicine_data$stringlen > 150),]


complete_science_data = rbind(science_medicine_data, science_space_data)
complete_science_data$label = "science"
names(complete_science_data) = c("data", "length_post", "label")

write.csv(complete_science_data, file = paste(getwd(), "/subsetdata/science_data.csv", sep = ""), row.names = F)
