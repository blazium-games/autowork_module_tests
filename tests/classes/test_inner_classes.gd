extends AutoworkTest

class TestInnerGroupOne extends AutoworkTest:
	func test_true_is_true():
		assert_true(true, "Inner group one: true is true")
		
	func test_false_is_false():
		assert_false(false, "Inner group one: false is false")

class TestInnerGroupTwo extends AutoworkTest:
	func before_all():
		gut.p("TestInnerGroupTwo before_all()")

	func test_math():
		assert_eq(2 + 2, 4, "Inner group two math works")
		
	func test_string():
		assert_eq("hello", "hello", "Inner group two string works")

func test_outer_class():
	assert_true(true, "Outer class test passed")
