library(progeny)

#get input data 
input_human <- get("input_human", envir = .GlobalEnv)
input_mouse <- get("input_mouse", envir = .GlobalEnv)

#get example output 
progeny_human_def_expected <- get("human_def_expected", envir = .GlobalEnv)
progeny_mouse_def_expected <- get("mouse_def_expected", envir = .GlobalEnv)
progeny_human_perm_expected <- get("human_perm_expected", envir = .GlobalEnv)
progeny_mouse_perm_expected <- get("human_perm_expected", envir = .GlobalEnv)

#obtaining actual result
progeny_human_def_act <- progeny(input_human, scale=TRUE, 
                                 organism = "Human", top = 10)
progeny_mouse_def_act <- progeny(input_mouse, scale=TRUE, 
                                 organism = "Mouse", top = 10)
progeny_human_perm_act <- progeny(input_human, scale=TRUE, perm = 1000, 
                                 organism = "Human", top = 10)
progeny_mouse_perm_act <- progeny(input_human, scale=TRUE, perm = 1000,
                                 organism = "Human", top = 10)

#testing
test_that("Comparison of the results", {
  expect_equal(progeny_human_def_act, progeny_human_def_expected)
  expect_equal(progeny_mouse_def_act, progeny_mouse_def_expected)
  expect_equal(progeny_human_perm_act, progeny_human_perm_expected, 
               tolerance = 0.3)
  expect_equal(progeny_mouse_perm_act, progeny_mouse_perm_expected, 
               tolerance = 0.3)
})

test_that("Wrong parameters", {
  expect_error(progeny(input_human, scale=TRUE, 
                         organism = "Test", top = 10),
               "Wrong organism name. Please specify 'Human' or 'Mouse'."
               )
  expect_error(progeny(input_human, scale=TRUE, 
                       organism = "Human", top = 0),
               "attempt to set 'rownames' on an object with no dimensions"
               )
  expect_error(progeny(input_human, scale=TRUE, 
                       organism = "Human", top = 10, perm = 0),
            "Wrong perm parameter. Please leave 1 by default or specify another
           value for application the permutation progeny function"
  )
})

