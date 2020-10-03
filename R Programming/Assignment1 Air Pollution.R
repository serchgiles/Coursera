# Coursera Task


read.csv("specdata/121.csv") %>% View()

pollutantmean <- function(directory, pollutant, id = 1:332){
  a <- numeric(0)
  for (archivo in list.files(directory)[id]) {
    datos <- read.csv(paste(directory, archivo, sep = "/"))
    a <- c(a, datos[[pollutant]])
  }
  mean(a, na.rm = TRUE)
}

complete <- function(directory, id = 1:332) {
  contador <- numeric(0)
  for (archivo in list.files(directory)[id]) {
    datos <- read.csv(paste(directory, archivo, sep = "/"))
    nobs <- sum(!(is.na(datos$sulfate)|is.na(datos$nitrate))) 
    contador <- c(contador, nobs)
  }
  #print(contador)
  data.frame("id" = id, "nobs" = contador)
}

corr <- function(directory, threshold = 0) {
  todos <- complete(directory)
  ids <- todos$id[todos$nobs > threshold]
  correlacion <- numeric(0)
  for (archivo in list.files(directory)[ids]) {
    datos <- read.csv(paste(directory, archivo, sep = "/"))
    value <- cor(x = datos$sulfate, y = datos$nitrate, 
                 use = "pairwise.complete.obs")
    correlacion <- c(correlacion, value)
  }
  correlacion
}
