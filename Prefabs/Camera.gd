extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_click"):
		var tap = get_viewport().get_mouse_position()
		var from = $Camera.project_ray_origin(tap)
		var to = from + $Camera.project_ray_normal(tap) * 10000
		var space_state = get_world().direct_space_state
		var obj = space_state.intersect_ray(from, to, [], 1).get("collider")
		print("Collision tested")
		if ( "isClickable" in obj and obj.isClickable):
			obj.clicked()
