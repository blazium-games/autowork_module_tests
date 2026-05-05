extends AutoworkTest


func test_basic_asserts():
	assert_true(true, "true is true")
	assert_false(false, "false is false")

	var answer = 42
	assert_true(answer == 42, "The answer is 42")
	assert_false(answer is String, "The answer is a number")


func test_comparing_asserts():
	assert_eq(1, 1, "1 == 1")
	assert_ne(1, 2, "1 != 2")
	assert_eq(Vector2.ZERO, Vector2(), "(0, 0) == (0, 0)")
	assert_ne(Vector3.ZERO, Vector3.ONE, "(0, 0, 0) != (1, 1, 1)")

	assert_lt(1, 2, "1 < 2")
	assert_gt(2, 1, "2 > 1")
	assert_lt(Vector2.ZERO, Vector2.ONE, "(0, 0) < (1, 1)")
	assert_gt(Vector3.ONE, Vector3.ZERO, "(1, 1, 1) > (0, 0, 0)")

	assert_le(1, 1, "1 <= 1")
	assert_ge(2, 1, "2 >= 1")
	assert_le(Vector2.ZERO, Vector2.ZERO, "(0, 0) <= (0, 0)")
	assert_ge(Vector3.ONE, Vector3.ZERO, "(1, 1, 1) >= (0, 0, 0)")

	assert_eq_deep(TestData.BLAZIUM, TestData.BLAZIUM, "Blazium is Blazium")
	assert_ne_deep(TestData.BLAZIUM, TestData.GODOT, "Blazium is not Godot")

	assert_almost_eq(1.0, 1.1, 0.1, "1 is almost 1.1")
	assert_almost_ne(1.0, 2.0, 0.1, "1 is not almost 2")

	assert_between(1, 0, 2, "1 is within range [0, 2]")
	assert_not_between(10, 0, 2, "10 is not within range [0, 2]")


func test_null_check_asserts():
	assert_null(null, "null is null")
	assert_not_null(self, "This script is not null")


func test_has_method_assert():
	assert_has_method(self, "test_has_method_assert", "This script has the method 'test_has_method_assert'")

	var node = Node.new()
	add_child_autoqfree(node)
	assert_has_method(node, "queue_free", "Node has the method 'queue_free'")


func test_has_asserts():
	var array = [1, 2, 3]
	assert_has(array, 2, "'array' has 2")
	assert_does_not_have(array, 9, "'array' does not have 9")

	assert_has(TestData.BLAZIUM, "colors", "'BLAZIUM' has the key 'colors'")
	assert_does_not_have(TestData.BLAZIUM.name, "first", "'BLAZIUM.name' does not have the key 'first'")
	
	var string = "Hello, World!"
	assert_has(string, "World", "'string' contains \"World\"")
	assert_does_not_have(string, "Goodbye", "'string' does not contain \"Goodbye\"")


func test_file_asserts():
	assert_dir_exists("res://", "The resources directory exists");
	assert_dir_does_not_exist("res://void", "The 'void' directory does not exist");

	assert_file_exists("res://README.md", "'README.md' exists");
	assert_file_does_not_exist("res://SECRETS.env", "'SECRETS.env' does not exist");

	assert_file_empty("res://data/empty.txt", "'empty.txt' is empty");
	assert_file_not_empty("res://README.md", "'README.md' is not empty");


func test_typeof_asserts():
	assert_typeof(self, TYPE_OBJECT, "This class is an Object");
	assert_not_typeof(42, TYPE_OBJECT, "42 is not an Object");


func test_is_assert():
	assert_is(self, "AutoworkTest", "This class extends AutoworkTest");


func test_string_asserts():
	var string = "Hello, World!"
	assert_string_contains(string, "World", "'string' contains \"World\"")
	assert_string_starts_with(string, "Hell", "'string' starts with \"Hell\"");
	assert_string_ends_with(string, "!", "'string' ends with \"!\"");
	
