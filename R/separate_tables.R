

separate_tables <- function(df = NULL, target = NULL, pos = 1){
  # get the unique values of the column to filter on
  vals <- unique(df[, target])
  # for each of these values, filter the df
  for (name in vals) {
    # assign filtered dfs with "df_value", remove any spaces in values
    assign(str_remove(paste("df", name, sep = "_"), " "),
           # use .data pronoun to filter by char vector columns
           filter(df, .data[[target]] == name), pos = as.environment(pos)
           )
  }
}
