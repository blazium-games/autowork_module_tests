extends AutoworkTest


func _before_all() -> void:
	print_log("[WARN]: The following tests are expected to fail.")


func test_basic_asserts():
	assert_true(false, "false is not true")
	assert_false(true, "true is not false")


func test_comparing_asserts():
	assert_eq(1, 2, "1 != 2")
	assert_ne(1, 1, "1 == 1")
	assert_eq(Vector2.ZERO, Vector2.ONE, "(0, 0) != (1, 1)")
	assert_ne(Vector3.ZERO, Vector3.ZERO, "(0, 0, 0) == (0, 0, 0)")

	assert_lt(2, 1, "2 > 1")
	assert_gt(2, 2, "2 == 2")
	assert_lt(Vector2.ONE, Vector2.ZERO, "(1, 1) > (0, 0)")
	assert_gt(Vector3.ONE, Vector3.ONE, "(1, 1, 1) == (1, 1, 1)")

	assert_le(2, 1, "2 > 1")
	assert_ge(1, 2, "1 < 2")
	assert_le(Vector2.ONE, Vector2.ZERO, "(1, 1) > (0, 0)")
	assert_ge(Vector3.ZERO, Vector3.ONE, "(0, 0, 0) < (1, 1, 1)")

	assert_eq_deep(TestData.BLAZIUM, TestData.GODOT, "Blazium is not Godot")
	assert_ne_deep(TestData.BLAZIUM, TestData.BLAZIUM, "Blazium is Blazium")

	assert_almost_eq(1.0, 2.0, 0.1, "1 is not almost 2")
	assert_almost_ne(1.0, 1.1, 0.1, "1 is almost 1.1")

	assert_between(10, 0, 2, "10 is not within range [0, 2]")
	assert_not_between(1, 0, 2, "1 is within range [0, 2]")
	

func test_null_checks_asserts():
	assert_null(self, "This script is not null")
	assert_not_null(null, "null is null")


func test_has_method_assert():
	assert_has_method(self, "magic_box", "This script does not have the method 'magic_box'")


func test_has_asserts():
	var array = [1, 2, 3]
	assert_has(array, 9, "'array' does not have 9")
	assert_does_not_have(array, 2, "'array' has 2")

	assert_has(TestData.BLAZIUM.name, "first", "'BLAZIUM.name' does not have the key 'first'")
	assert_does_not_have(TestData.BLAZIUM, "colors", "'BLAZIUM' has the key 'colors'")
	
	var string = "Hello, World!"
	assert_has(string, "Goodbye", "'string' does not contain \"Goodbye\"")
	assert_does_not_have(string, "World", "'string' contains \"World\"")


func test_file_asserts():
	assert_dir_exists("res://void", "The 'void' directory does not exist");
	assert_dir_does_not_exist("res://", "The resources directory exists");

	assert_file_exists("res://SECRETS.env", "'SECRETS.env' does not exist");
	assert_file_does_not_exist("res://README.md", "'README.md' exists");

	assert_file_empty("res://README.md", "'README.md' is not empty");
	assert_file_not_empty("res://data/empty.txt", "'empty.txt' is empty");


func test_typeof_asserts():
	assert_typeof(self, TYPE_INT, "This class is an Object");
	assert_not_typeof(42, TYPE_INT, "42 is an int");


func test_is_assert():
	assert_is(self, "Node2D", "This class extends AutoworkTest");


func test_string_asserts():
	var string = "Hello, World!"
	assert_string_contains(string, "Goodbye", "'string' does not contain \"Goodbye\"")
	assert_string_starts_with(string, "Heaven", "'string' does not start with \"Heaven\"");
	assert_string_ends_with(string, "?", "'string' does not end with \"?\"");
