extends Node2D

signal round_change(new_round)

var mob := preload("res://entities/enemies/mob.tscn")

@onready var round_num := 1
@onready var round_timer := 0.0
@onready var player = get_node("/root/Test/Player")


func _process(delta: float) -> void:
	# Round timer updates, after 30 seconds round updates
	round_timer += delta
	if round_timer >= 30:
		round_timer = 0
		round_num += 1
		round_change.emit(round_num)
	
	# spawn path follows the player
	# spawning always out of view
	# random spawning anywhere on path2d rectangle
#mob blueprints
@export var RangedMob: PackedScene
@export var TankMob: PackedScene
func spawn_mob():
	var new_mob = mob.instantiate()
	var new_rangedmob = RangedMob.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	add_child(new_rangedmob)
	#Only one tank mob at at time
	if get_tree().get_node_count_in_group("tanks") == 0:
		var new_tankmob = TankMob.instantiate()
		new_tankmob.add_to_group("tanks")
		
		%PathFollow2D.progress_ratio = randf()
		new_tankmob.global_position = %PathFollow2D.global_position
		add_child(new_tankmob)
	
	#connected spawner to timer
	#change wait time in inspector for timer to increase or decrease rate


func _on_timer_timeout():
	spawn_mob()
