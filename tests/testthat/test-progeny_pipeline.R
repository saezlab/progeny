library(progeny)

#get input data
human_input <- as.matrix(read.csv(system.file("extdata", "human_input.csv", 
                                              package = "progeny"), 
                                  row.names = 1))
mouse_input <- as.matrix(read.csv(system.file("extdata", "mouse_input.csv", 
                                              package = "progeny"), 
                                  row.names = 1))

#get expected data
human_def_expected <- read.csv(system.file("extdata", "human_def_expected.csv", 
                                           package = "progeny"),
                               row.names = 1,
                               check.names = FALSE)
mouse_def_expected <- read.csv(system.file("extdata", "mouse_def_expected.csv", 
                                           package = "progeny"),
                               row.names = 1, 
                               check.names = FALSE)

#obtaining actual result
human_def_act <- as.data.frame(progeny(human_input, scale=TRUE, 
                                 organism = "Human", top = 10))
mouse_def_act <- as.data.frame(progeny(mouse_input, scale=TRUE, 
                                 organism = "Mouse", top = 10))

#testing
test_that("Comparison of the results", {
  expect_equal(human_def_act, human_def_expected)
  expect_equal(mouse_def_act, mouse_def_expected)
})
