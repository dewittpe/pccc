# See test_ccc_icd9.R for data setup
#
# Pverview of tests for ICD 10
#     X invalid input (not real ICD codes)
#     X check output for saved file - if it changes, I want to know
#     X no input
#     X need to test each category of CCC
#     performance test?
#
library(pccc)

# "random data set with all parameters ICD10 - result should be unchanged."
ccc_out <- ccc(data.frame(id = letters[1:3],
                          dx1 = c('sadcj89sa', '1,2.3.4,5', 'sdf 9'),
                          pc1 = c('da89v#$%', ' 90v_', 'this is a super long string compared to standard ICD codes and shouldnt break anything - if it does, the world will come to an end... Ok, so maybe not, but that means I need to fix something in this package.'),
                          other_col = LETTERS[1:3]),
               id      = id,
               dx_cols = dplyr::starts_with("dx"),
               pc_cols = dplyr::starts_with("pc"),
               icdv    = 10)
ccc_out$id <- as.factor(ccc_out$id)
rnd_test <- readRDS("random_data_test_result.rds")
rnd_test$id <- as.factor(rnd_test$id)
stopifnot(isTRUE(all.equal(ccc_out, rnd_test)))


#test_that("icd 10 data set with all parameters - result should be unchanged.", {

df <-
  ccc(pccc::pccc_icd10_dataset[, c(1:21)],
      id      = id,
      dx_cols = dplyr::starts_with("dx"),
      pc_cols = dplyr::starts_with("pc"),
      icdv    = 10)

expected <- readRDS("icd10_test_result.rds")

stopifnot(isTRUE(all.equal(df, expected)))

################################################################################
#                                 End of File                                  #
################################################################################
