extends KinematicBody

var path = []
var path_ind = 0
const move_speed = 5
onready var amap = get_parent()
func _ready():
	add_to_group("units")

func _physics_process(delta):
	if path_ind < path.size():
		var move_vec = (path[path_ind] - global_transform.origin)
		if Vector2(move_vec.x,move_vec.z).length() < 0.1:
			path_ind += 1
		else:
			move_vec[1] = 0;
			move_and_slide_with_snap(move_vec.normalized() * move_speed, Vector3(0, -1, 0),Vector3(0, 1, 0))

func move_to(target_pos):
	print("-------+->"+str(global_transform.origin))
	path = amap.get_path_astart(global_transform.origin, target_pos)
	print("--->"+str(path))
	path_ind = 0
