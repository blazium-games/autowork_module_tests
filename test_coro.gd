extends SceneTree

func _init():
	var ret = call("my_coro")
	print("Call returned type: ", typeof(ret))
	if typeof(ret) == TYPE_SIGNAL:
		var sig = ret as Signal
		print("Returned signal: ", sig.get_name(), " on ", sig.get_object())
		await sig
		print("Finished await!")
	quit()

func my_coro():
	print("coro start")
	await create_timer(0.1).timeout
	print("coro end")
