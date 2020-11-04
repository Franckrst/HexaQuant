extends Spatial

var pitch = -45.0
var yaw = -45.0
var offset
var node_to_follow = "/root/Spatial/AMap/Mannequiny"

func _ready():
	var playerPos = get_node(node_to_follow).translation
	var camPos = translation
	offset = camPos - playerPos
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var from = $Camera.project_ray_origin(event.position)
		var to = from + $Camera.project_ray_normal(event.position) * 1000
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(from, to, [], 1)
		if result:
			var x = result.get("collider").transform.origin;
			get_tree().call_group("units", "move_to", result.get("collider").transform.origin)


func _physics_process(delta):
	var playerPos = get_node(node_to_follow).translation
	set_translation(playerPos + offset)
	if Input.is_action_just_pressed("ui_left"):
		self.yaw -= 90.0
	if Input.is_action_just_pressed("ui_right"):
		self.yaw += 90.0
	if Input.is_action_just_pressed("ui_up"):
		self.pitch -= 15.0
	if Input.is_action_just_pressed("ui_down"):
		self.pitch += 15.0
	self.pitch = clamp(self.pitch, -60.0, -30.0)
	var rotateFrom = self.get_rotation()
	var to = Vector3(deg2rad(self.pitch), deg2rad(self.yaw), 0.0)
	var euler = rotateFrom.linear_interpolate(to, delta * 6.0)
	self.set_rotation(euler)
