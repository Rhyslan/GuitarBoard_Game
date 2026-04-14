extends Control

# Resource variables
var health_bar
var shield_bar
var beam_bar
var ammo_count
var slash_cd

# Round and Score variables
var round_tracker
var score_tracker

# Pause menu
var pause_menu
var unpause_button
var quit_button
# Game over menu
var game_over_menu
var retry_button
var go_quit_button

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the resource nodes to prepare to change their values
	health_bar = get_node("Resources/VBoxContainer/HealthBar")
	shield_bar = get_node("Resources/VBoxContainer/HBoxBeamShield/ShieldBar")
	beam_bar = get_node("Resources/VBoxContainer/HBoxBeamShield/BeamBar")
	ammo_count = get_node("Resources/VBoxContainer/HBoxGunSlash/Ammo")
	slash_cd = get_node("Resources/VBoxContainer/HBoxGunSlash/SlashCD")
	
	round_tracker = get_node("RoundScore/VBoxContainer/Round")
	round_tracker.text = "Round: 1"
	
	# Get pause menu ready
	pause_menu = get_node("PauseMenu")
	unpause_button = get_node("PauseMenu/VBoxContainer/UnpauseButton")
	quit_button = get_node("PauseMenu/VBoxContainer/QuitButton")
	unpause_button.pressed.connect(_unpause)
	quit_button.pressed.connect(_quit)
	pause_menu.hide()
	# Get game over menu ready, same structure
	game_over_menu = get_node("GameOverMenu")
	retry_button = get_node("GameOverMenu/VBoxContainer/RetryButton")
	go_quit_button = get_node("GameOverMenu/VBoxContainer/QuitButton")
	retry_button.pressed.connect(_retry)
	go_quit_button.pressed.connect(_quit)
	game_over_menu.hide()

# TODO: Change UI values to match game values, i.e. health_bar.value = Player Health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_test_round_change(new_round):
	round_tracker.text = "Round: " + str(new_round)

func _on_player_pause_pressed() -> void:
	get_tree().paused = true
	pause_menu.show()

func _on_player_game_over_signal() -> void:
	get_tree().paused = true
	game_over_menu.show()

func _unpause():
	pause_menu.hide()
	get_tree().paused = false

func _retry():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _quit():
	# Has to unpause otherwise gets stuck on title screen
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title/title_screen.tscn")
