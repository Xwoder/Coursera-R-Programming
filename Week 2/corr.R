source("complete.R")

corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0

    ## Return a numeric vector of correlations

    # 设置数据文件目录
    if (directory == "specdata") {
        # 数据文件目录
        directory <- "./specdata/"
    }

    complete_table <- complete("specdata", 1:332)
    nobs <- complete_table$nobs

    id_vec <- complete_table$id[nobs > threshold]

    id_len <- length(id_vec)
    corr_vector <- rep(0, id_len)

    # 数据文件的文件名向量
    file_name_vec <- list.files(directory)
    # 数据文件的文件路径向量
    file_path_vec <- paste0(directory, file_name_vec)

    j <- 1
    for (i in id_vec) {
        current_file <- read.csv(file = file_path_vec[i],
                                 header = T,
                                 sep = ",")
        corr_vector[j] <- cor(x = current_file$sulfate,
                              y = current_file$nitrate,
                              use = "complete.obs")
        j <- j + 1
    }
    result <- corr_vector
    return(result)
}

cr <- corr(directory = "specdata", threshold = 150)
head(cr)
summary(cr)

cr <- corr(directory = "specdata", threshold = 400)
head(cr)
summary(cr)

cr <- corr(directory = "specdata", threshold =5000)
head(cr)
summary(cr)

cr <- corr("specdata")
summary(cr)
length(cr)