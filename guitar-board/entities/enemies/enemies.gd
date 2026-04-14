class_name Mob extends CharacterBody2D
# EnemyLogic all here, use as script for all enemies
# Change variables (hp, etc) for individual enemies

@export var health := 2.0
@export var dmg_per_sec := 1.0

@onready var player := get_node("/root/Test/Player")


#follows player position
func _physics_process(delta: float):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	
	#enemy collision
	#for i in get_slide_collision_count():
	#	var collision = get_slide_collision(i)
	#	var collider = collision.get_collider()


# Deletes mob when hp = 0
func take_damage(damage_taken: float):
	health -= damage_taken
	# sub in hurt animation here
	
	if health <= 0.0:
		queue_free()
	# death animation down here (add as child) and play on global pos
