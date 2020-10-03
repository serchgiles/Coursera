# 3rd assignment R Programming
# HOSPITAL QUALITY
#######################
# This functions returns the best hospital in with the low rate of the
# disease passed by outcome as an argument in the given state 

best <- function(state, outcome){

     file_path <- "R Programming/hospital/outcome-of-care-measures.csv"
     
     datos <- read.csv(file = file_path, stringsAsFactors = F)

     #Check if state is a valid one
     state <- toupper(state)
     if (! state %in% unique(datos[,7])) {
          stop("Non Valid State Argument")
     }

     #Check if outcome is a valid one
     outcome.opts <- list("heart attack" = 11, "heart failure" = 17,
                          "pneumonia" = 23)
     
     outcome <- names(outcome.opts)[grep(outcome, names(outcome.opts), 
                                         ignore.case = T)]
     
     if (length(outcome)!=1) {
          stop("Outcome Argument Non Valid")
     }
     
     #Getting the column index of the respective outcome
     col.ind <- outcome.opts[[outcome]]
                                                                             
     #Get the dataframe of the selected state
     state.df <- split(datos[, c(2,col.ind)], datos[,7])[[state]]
     
     #Coerce rates as numeric values
     state.df[,2] <- suppressWarnings(as.numeric(state.df[,2]))
      
     #Get the list of 
     hospitals <- state.df[,1][state.df[,2] ==
                                    min(state.df[,2], na.rm = T)]
     
     sort(hospitals)[1]
}

rankhospital <- function(state, outcome, num = "best") {
        
        file_path <- "R Programming/hospital/outcome-of-care-measures.csv"
        
        datos <- read.csv(file = file_path, stringsAsFactors = F)

        #Check if state is a valid one
        state <- toupper(state)
        if (! state %in% unique(datos[,7])) {
                stop("Non Valid State Argument")
        }
        
        #Check if outcome is a valid one
        outcome.opts <- list("heart attack" = 11, "heart failure" = 17, 
                             "pneumonia" = 23)
        
        outcome <- names(outcome.opts)[grep(outcome, names(outcome.opts), 
                                            ignore.case = T)]
        
        if (length(outcome)!=1) {
                stop("Outcome Argument Non Valid")
        }
        
        #Check if the num arg is valid
        
        if (!((is.numeric(num) & num > 0) | num %in% c("worst", "best"))){
                stop("Num argument is not valig")
        }
        #Getting the column index of the respective outcome
        col.ind <- outcome.opts[[outcome]]
        
        #Get the dataframe of the selected state
        state.df <- split(datos[, c(2,col.ind)], datos[,7])[[state]]
        
        #Coerce rates as numeric values
        state.df[,2] <- suppressWarnings(as.numeric(state.df[,2]))
        
        state.df <- state.df[order(state.df[,2], state.df[,1], 
                                   na.last = NA),]
        
        if (num == "worst") {
                state.df[length(state.df[,1]),1]
        }else if (num == "best"){
                state.df[1,1]
        }else if (num > length(state.df[,2])){
                NA
        }else{
                state.df[num,1]
        }

}
     

rankall <- function(outcome, num = "best") {
  
  file_path <- "R Programming/hospital/outcome-of-care-measures.csv"
  
  datos <- read.csv(file = file_path, stringsAsFactors = F)

  all.states <- sort(unique(datos[,7]))
  df <- as.data.frame(cbind(sapply(all.states, function(x) rankhospital(state = x, 
                                              outcome = outcome, 
                                              num = num)), all.states))
  
  names(df) <- c("hospital", "state")
  return(df)
}
