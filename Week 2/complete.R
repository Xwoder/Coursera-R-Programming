complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length l indicating
    ## the location of the CSV files

    # 'id' is an integer vector indicating the monitor ID numbers
    ## to be used

    ## Return a data frame of the form:
    ## id nobs
    ## 1 117
    ## 2 1041
    # ...
    # where id' is the monitor ID number and 'nobs' is the
    # number of complete cases

    # 设置数据文件目录
    if (directory == "specdata") {
        # 数据文件目录
        directory <- "./specdata/"
    }

    # 数据文件的文件名向量
    file_name_vec <- list.files(directory)
    # 数据文件的文件路径向量
    file_path_vec <- paste0(directory, file_name_vec)

    nob_vec <- c()

    for (file_path in file_path_vec[id]) {
        # 读取 CSV 文件中的数据
        df_csv <- read.csv(file_path,
                           header = TRUE,
                           sep = ',')
        # 计算所有记录的各项数据均为非空的的数量和
        numberOfCasesWithoutMissingValues = sum(complete.cases(df_csv))

        nob_vec <- c(nob_vec, numberOfCasesWithoutMissingValues)
    }

    result <- data.frame(id = id, nobs = nob_vec)
    result
}


complete("specdata", 1)

complete("specdata", c(2, 4, 8, 10, 12))

complete("specdata", 30:25)

complete("specdata", 3)

complete("specdata", c(6, 10, 20, 34, 100, 200, 310))

cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
cc$nobs
# 228 148 124 165 104 460 232

cc <- complete("specdata", 54)
cc$nobs
# 219

RNGversion("3.5.1")
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
cc[use, "nobs"]
# 711 135  74 445 178  73  49   0 687 237
