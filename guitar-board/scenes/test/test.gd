extends Node2D

signal round_change(new_round)

var input_list := "Actions pressed:\n"
var mob := preload("res://entities/enemies/mob.tscn")

@onready var round_num := 1
@onready var round_timer := 0.0
@onready var player = get_node("/root/Test/Player")


func _process(delta: float) -> void:
	input_list = "Actions pressed:\n"
	# Movement
	if Input.is_action_pressed("Up"):
		input_list += "Move Up\n"
	if Input.is_action_pressed("Down"):
		input_list += "Move Down\n"
	if Input.is_action_pressed("Left"):
		input_list += "Move Left\n"
	if Input.is_action_pressed("Right"):
		input_list += "Move Right\n"
	# Actions
	if Input.is_action_pressed("Jump"):
		input_list += "Jump\n"
	if Input.is_action_pressed("Gun"):
		input_list += "Gun attack selected\n"
	if Input.is_action_pressed("Beam"):
		input_list += "Beam attack selected\n"
	if Input.is_action_pressed("Slash"):
		input_list += "Slash attack selected\n"
	if Input.is_action_pressed("Dash"):
		input_list += "Dash selected\n"
	if Input.is_action_pressed("Shield"):
		input_list += "Shield selected\n"
	if Input.is_action_pressed("Attack"):
		input_list += "Activating selection\n"
	if Input.is_action_pressed("Reload"):
		input_list += "Reloading\n"
	
	# Pausing
	if Input.is_action_just_pressed("Pause"):
		input_list += "Game Paused\n"
	
	$"UI Canvas/UI/Label".text = input_list
	#$CanvasLayer/UI/Health.text = "Health: " + str(player.health)
	
	# Round timer updates, after 30 seconds round updates
	round_timer += delta
	if round_timer >= 30:
		round_timer = 0
		round_num += 1
		round_change.emit(round_num)
	
	# spawn path follows the player
	# spawning always out of view
	# random spawning anywhere on path2d rectangle


func spawn_mob():
	var new_mob = mob.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	#connected spawner to timer
	#change wait time in inspector for timer to increase or decrease rate


func _on_timer_timeout():
	spawn_mob()
