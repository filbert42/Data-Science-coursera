complete <- function(directory,  id = 1:332) {
        my_dir<-getwd()
        setwd(directory)
        complete_vector <- c()
        for (i in id ) {
                current_file<- read.csv(list.files(directory)[i])
                complete_vector <- c(complete_vector, sum(complete.cases(current_file)))
        }
        
        setwd(my_dir)
        complete_frame <- data.frame(id=id, nobs= complete_vector)
        complete_frame
}

  