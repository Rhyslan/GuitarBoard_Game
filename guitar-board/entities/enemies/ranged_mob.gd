extends Mob #Inherit mob stats

#Ranged Mob Stats
@export var attack_range := 400.0
@export var stop_range := 350.0
@export var fire_rate := 2
@export var enemyprojectile_scene: PackedScene

var can_shoot := true

func _physics_process(_delta: float):
	var distance_to_player = global_position.distance_to(player.global_position)
	var direction = global_position.direction_to(player.global_position)
	look_at(player.global_position)
	#Movement + Pause
	if distance_to_player > stop_range:
		velocity = direction * 200.0
	else:
		velocity = Vector2.ZERO

	velocity += knockback_vel
	move_and_slide()
	
	# Ranged Attack Logic
	if distance_to_player <= attack_range and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	#Create Projectile
	var projectile = enemyprojectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	#Trajectory
	projectile.global_position = global_position
	projectile.direction = global_position.direction_to(player.global_position)
	projectile.rotation = projectile.direction.angle()
	
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
