pollutantmean <- function(directory, pollutant, id = 1:332) {
    if (directory == "specdata") {
        # 数据文件目录
        directory <- "./specdata/"
    }

    # 数据文件的文件名向量
    file_name_vec <- list.files(directory)
    # 数据文件的文件路径向量
    file_path_vec <- paste0(directory, file_name_vec)

    # 存放规定的污染的全体数据的向量
    pollutant_all_vec <- c()

    # 遍历所需的所有数据文件
    for (file in file_path_vec[id]) {
        # 读取 csv 格式的数据文件
        df_csv <- read.csv(file,
                           header = TRUE,
                           sep = ',')
        # 过滤空数据，取出规定的污染物数据列
        pollutant_nona_vec <- df_csv[!is.na(df_csv[pollutant]), pollutant]

        # 将当前文件中规定的污染物数据，添加到存放规定的污染物的全体数据的向量
        pollutant_all_vec <- c(pollutant_all_vec, pollutant_nona_vec)
    }

    # 计算规定的污染物数据的均值并返回
    mean(pollutant_all_vec)
}

pollutantmean(directory = "specdata",
              pollutant = "sulfate",
              id = 1:10)

pollutantmean(directory = "specdata",
              pollutant = "nitrate",
              id = 70:72)

pollutantmean(directory = "specdata",
              pollutant = "nitrate",
              id = 23)