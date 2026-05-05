extends AutoworkTest


func test_aliases():
	p("p: Testing aliases.")

	assert_lte(1, 2, "lte: 1 <= 2")
	assert_lte(2, 2, "lte: 2 <= 2")

	assert_gte(2, 1, "gte: 2 >= 1")
	assert_gte(2, 2, "gte: 2 >= 2")