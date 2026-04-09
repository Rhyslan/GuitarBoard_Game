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



func get_hit(health_lost):
	health-=health_lost
	
	if health <= 0:
		game_over()
		

#game over (temp)
func game_over():
	health = 0
	print("Game Over!")
	
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	#everything the player hits
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collision.get_collider().name == "Mob":
			get_hit(2)
	
