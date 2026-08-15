extends AutoworkTest


func test_wait_process_frames():
	var start_frame = Engine.get_process_frames()
	await wait_process_frames(10, "Waiting exactly 10 process frames")
	
	var diff = Engine.get_process_frames() - start_frame
	if (diff == 10):
		pass_test("Successfully waited 10 process frames")
	else:
		fail_test("Error waiting 10 process frames. Difference of %d frames" % diff)


func test_wait_physics_frames():
	var start_frame = Engine.get_physics_frames()
	await wait_physics_frames(10, "Waiting exactly 10 physics frames")

	var diff = Engine.get_physics_frames() - start_frame
	if (diff == 10):
		pass_test("Successfully waited 10 physics frames")
	else:
		fail_test("Error waiting 10 physics frames. Difference of %d frames" % diff)


func test_wait_seconds():
	var start_time = Time.get_ticks_msec()
	await wait_seconds(2.0, "Waiting 2 seconds")
	
	var diff = Time.get_ticks_msec() - start_time
	if (assert_almost_eq(diff, 2000, 250)):
		pass_test("Waited %s seconds." % (diff / 1000.0))
	else:
		fail_test("Error waiting 2 seconds. Waited %d ms" % diff)


func test_wait_for_signal():
	var node = Node.new()
	add_child_autoqfree(node)
	node.call_deferred("emit_signal", "ready")
	
	var did_emit = await wait_for_signal(node.ready, 2.0, "Wait for Node to emit 'ready'")
	if (did_emit):
		pass_test("Successfully waited for 'ready' signal")
	else:
		fail_test("Error waiting for 'ready' signal")


var a: int = 10
func test_wait_while_until():
	if (await wait_while(func(): a -= 1; return a > 0, 2, "waiting while a > 0")):
		pass_test("Successfully waited while a > 0")
	else:
		fail_test("Timeout")

	a = 10

	if (await wait_until(func(): a -= 1; return a <= 0, 2, "waiting until a <= 0")):
		pass_test("Successfully waited until a <= 0")
	else:
		fail_test("Timeout")
