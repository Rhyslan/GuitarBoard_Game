extends CharacterBody2D


@export var speed = 400.0
@export var rot_speed = 5.0
var rot_vel = 0
var health = 100

func get_input():
	# Rotation
	rot_vel = Input.get_axis("Spin Left", "Spin Right")
	rotation += deg_to_rad(rot_vel * rot_speed)

	# Movement
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_dir * speed

func get_hit():
	health-=2


	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().name == "Mob":
			get_hit()
	
