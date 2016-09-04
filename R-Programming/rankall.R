rankall <- function(outcome, num ="best") {
        ## проверяем валидность переменных
        valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
                if(!outcome %in% valid_outcomes) {
                stop("invalid outcome")
        } else {
                ## читаем файл
                data <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)
                ## создаем вектор, переводящий outcome в номер столбца
                column_index <- c("heart attack"= 11, "heart failure" = 17, "pneumonia"= 23)
                ## выбираем из данных только нужные три столбца
                ## госпиталь (2), штат (7), причину (outcome)
                current_data <- data[, c(2,7,column_index[outcome])]
                ## очищаем строки от NA
                no_na <- current_data[complete.cases(current_data), ]
                ## присваиваем столбцам понятные имена
                names(no_na) <- c("hospital", "state", "outcome")
                ##ранжируем no_na по штату, причине и госпиталю
                ranked <- no_na[order(no_na$outcome, no_na$hospital), ]
                ## разбиваем на группы по штату
                state_gr <- split(ranked, ranked$state)
                ## функция для sapply
                hospitalRank <- function(x, num){
                        if (num == "best"){
                                min_out <- c()
                                min_out  <- as.character(c(min_out, x[1, "hospital"]))
                        } else if (num == "worst") {
                                min_out <- c()
                                min_out <- as.character(c(min_out, x[nrow(x), "hospital"]))
                                
                        } else {
                                min_out <- c()
                                min_out <- as.character(c(min_out, x[num, "hospital"]))
                        }
                }
                
                ## создаем вектор с названиями лучших госпиталей
                rank_vect <- sapply(state_gr, hospitalRank, num)
                ## превращаем вектор в датафрейм с нужными столбцами
                rank_table <- data.frame(hospital = rank_vect, state = names(rank_vect), row.names = names(rank_vect)) 
        
        }
}