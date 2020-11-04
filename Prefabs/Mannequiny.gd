extends KinematicBody

var path = []
var path_ind = 0
const move_speed = 8
onready var amap = get_parent()
func _ready():
	add_to_group("units")

func _physics_process(delta):
	if path_ind < path.size():
		var move_vec = (path[path_ind] - global_transform.origin)
		if Vector2(move_vec.x,move_vec.z).length() < 0.1:
			path_ind += 1
		else:
			if is_on_floor():
				move_vec[1] = 0;
			var toto = move_vec.normalized()*move_speed
			#move_and_slide_with_snap(move_vec.normalized()*move_speed,Vector3.DOWN,Vector3.DOWN,true)
			move_and_slide(move_vec.normalized()*move_speed,Vector3.UP,true)
			print(str(rad2deg(Vector3.BACK.angle_to(toto))))
			self.set_rotation(Vector3(0,atan2(toto.x, toto.z),0))
			$AnimationPlayer.play("run")
			print(str(self.get_rotation()))
	else:
		$AnimationPlayer.stop()

func move_to(target_pos):
	print("-------+->"+str(global_transform.origin))
	path = amap.get_path_astart(global_transform.origin, target_pos)
	print("--->"+str(path))
	path_ind = 0
