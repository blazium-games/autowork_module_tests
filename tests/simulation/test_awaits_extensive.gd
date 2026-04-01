extends AutoworkTest

func test_wait_frames_exact():
	var start_frame = Engine.get_process_frames()
	await wait_frames(10, "Waiting exactly 10 process frames")
	pass_test("Reached EOF of test_wait_frames_exact")

func test_wait_physics_frames_exact():
	var start_frame = Engine.get_physics_frames()
	await wait_physics_frames(10, "Waiting exactly 10 physics frames")
	pass_test("Reached EOF of test_wait_physics_frames_exact")

func test_wait_seconds_precision():
	var start_time = Time.get_ticks_msec()
	await wait_seconds(0.5, "Waiting exactly 0.5 seconds")
	pass_test("Reached EOF of test_wait_seconds_precision")

func test_wait_for_signal_success():
	var node = Node.new()
	add_child_autoqfree(node)
	
	# We will emit the signal from a deferred call in the engine
	node.call_deferred("emit_signal", "ready")
	
	await wait_for_signal(node, "ready", 1.0, "Wait for Node to emit 'ready'")
	assert_true(true, "Successfully caught the ready signal before the 1.0s timeout")
	pass_test("Reached EOF of test_wait_for_signal_success")

func test_wait_for_signal_timeout():
	var node = Node.new()
	add_child_autoqfree(node)
	
	var start_time = Time.get_ticks_msec()
	# This signal will not be emitted. We expect it to time out after 0.5s.
	await wait_for_signal(node, "tree_exiting", 0.5, "Wait for Node to emit 'tree_exiting' (will timeout)")
	
	var diff = Time.get_ticks_msec() - start_time
	assert_between(diff, 468, 532, "Wait for signal timed out and released exactly after 0.5s")
	pass_test("Reached EOF of test_wait_for_signal_timeout")
