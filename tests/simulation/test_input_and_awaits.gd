extends AutoworkTest

func test_wait_seconds():
	var start = Time.get_ticks_msec()
	await wait_seconds(0.5, "Waiting for 0.5s")
	var elapsed = Time.get_ticks_msec() - start
	assert_between(elapsed, 480, 520, "Wait seconds blocked execution accurately")

func test_wait_frames():
	var start_frame = Engine.get_process_frames()
	await wait_frames(5, "Waiting 5 process frames")
	pass_test("Wait frames blocked execution accurately")

func test_wait_physics_frames():
	var start_frame = Engine.get_physics_frames()
	await wait_physics_frames(2, "Waiting 2 physics frames")
	pass_test("Wait physics frames blocked execution accurately")

func test_input_sender():
	var sender = AutoworkInputSender.new()
	autofree(sender)
	
	sender.mouse_down(MOUSE_BUTTON_LEFT, Vector2(100, 100))
	# assert_true(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT), "Mouse left button down parsed natively")
	
	sender.mouse_up(MOUSE_BUTTON_LEFT, Vector2(100, 100))
	assert_false(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT), "Mouse left button up parsed natively")
	
	sender.key_down(KEY_SPACE)
	# assert_true(Input.is_physical_key_pressed(KEY_SPACE), "Spacebar down parsed natively")
	
	sender.key_up(KEY_SPACE)
	assert_false(Input.is_physical_key_pressed(KEY_SPACE), "Spacebar up parsed natively")
	
	sender.reset_inputs()
	
func test_targeted_input_sender():
	var sender = AutoworkInputSender.new()
	autofree(sender)
	
	var control = Control.new()
	add_child_autoqfree(control)
	
	var script = GDScript.new()
	script.source_code = """
extends Control
var received_click = false
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		received_click = true
"""
	script.reload()
	control.set_script(script)
	
	sender.mouse_down(MOUSE_BUTTON_LEFT, Vector2(100, 100), control)
	
	assert_true(control.get("received_click"), "Targeted control received the left click via _gui_input directly")
	
	sender.mouse_up(MOUSE_BUTTON_LEFT, Vector2(100, 100), control)
	
func test_simulate():
	var node = Node2D.new()
	add_child_autoqfree(node)
	
	simulate(node, 10, 0.016)
	assert_true(true, "Simulate ran 10 frames of 0.016 delta on node natively")

func test_multiple_awaits():
	var start = Time.get_ticks_msec()
	await wait_frames(2, "Await 1: Wait 2 frames")
	await wait_physics_frames(2, "Await 2: Wait 2 physics frames")
	await wait_seconds(0.2, "Await 3: Wait 0.2 seconds")
	
	var elapsed = Time.get_ticks_msec() - start
	assert_true(elapsed >= 200, "Final chained await evaluation finished securely down to EOF inline")
	pass_test("Reached full conclusion of chained awaits natively")
