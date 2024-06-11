extends RigidBody3D

@onready var head = $head/Camera3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_speed := 1000.0
	var max_speed := 10.0
	var jump_strength := 1000.0
	var force := Vector3.ZERO
	
	if Input.is_action_pressed("forward"):
		force += -transform.basis.z * move_speed * delta
	if Input.is_action_pressed("backward"):
		force += transform.basis.z * move_speed * delta
	if Input.is_action_pressed("left"):
		force += -transform.basis.x * move_speed * delta
	if Input.is_action_pressed("right"):
		force += transform.basis.x * move_speed * delta
	
	if Input.is_action_pressed("jump"):
		force += transform.basis.y * jump_strength * delta
	apply_central_force(force)
	
	#clamping
	move_speed = linear_velocity.length()
	move_speed = clamp(move_speed,0,max_speed)
	
	#limit
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
	
	
	print("move speed: ", move_speed)
	print("max speed: ", max_speed)

func _input(event):
	if event is InputEventScreenDrag:
		var look_sensitivity = 0.5
		rotate_y(deg_to_rad(-event.relative.x * look_sensitivity))
		$head.rotate_x(deg_to_rad(-event.relative.y * look_sensitivity))
		
		var head_rotation = $head.rotation_degrees
		head_rotation.x -= event.relative.y * look_sensitivity
		head_rotation.x = clamp(head_rotation.x, -90, 90)
		$head.rotation_degrees = head_rotation
		
		
	
