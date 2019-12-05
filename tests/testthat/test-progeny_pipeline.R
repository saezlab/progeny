library(progeny)

#get test gene expression datasets
gene_expr_human = get("gene_expr_human", envir = .GlobalEnv)
gene_expr_mouse = get("gene_expr_mouse", envir = .GlobalEnv)

#get example output
result_human_expected = get("result_human_expected", envir = .GlobalEnv)
result_mouse_expected = get("result_mouse_expected", envir = .GlobalEnv)


#Obtaining actual result
result_human_actual <- progeny(gene_expr_human, scale=TRUE, 
                                 organism = "Human", top = 10)
result_mouse_actual <- progeny(gene_expr_mouse, scale=TRUE, 
                                 organism = "Mouse", top = 10)

#Testing
test_that("Comparison of the results", {
  expect_equal(result_human_actual, result_human_expected)
  expect_equal(result_mouse_actual, result_mouse_expected)
})

test_that("Wrong parameters", {
  expect_error(progeny(gene_expr_human, scale=TRUE, 
                         organism = "Test", top = 10),
               "Wrong organism name. Please specify 'Human' or 'Mouse'."
               )
  expect_error(progeny(gene_expr_human, scale=TRUE, 
                       organism = "Human", top = 0),
               "attempt to set 'rownames' on an object with no dimensions"
               )
})

