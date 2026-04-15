class_name GameUI extends Control

var score := 0

# Resource variables
@onready var health_bar: TextureProgressBar = $HealthContainer/HealthBar
@onready var gun_bar: TextureProgressBar = $ResourcesContainer/VBoxContainer/HBoxContainer/Gun
@onready var gun_colour: Color = gun_bar.tint_progress
@onready var beam_bar: TextureProgressBar = $ResourcesContainer/VBoxContainer/HBoxContainer/Beam
@onready var beam_colour: Color = beam_bar.tint_progress
@onready var slash_bar: TextureProgressBar = $ResourcesContainer/VBoxContainer/HBoxContainer/Slash
@onready var slash_colour: Color = slash_bar.tint_progress
@onready var dash_bar: TextureProgressBar = $ResourcesContainer/VBoxContainer/HBoxContainer/Dash
@onready var dash_colour: Color = dash_bar.tint_progress
@onready var shield_bar: TextureProgressBar = $ResourcesContainer/VBoxContainer/HBoxContainer/Shield
@onready var shield_colour: Color = shield_bar.tint_progress

# Round and Score variables
@onready var round_tracker: Label = $RoundScoreContainer/HBoxContainer/Round
@onready var score_tracker: Label = $RoundScoreContainer/HBoxContainer/Score

# Pause Menu
@onready var pause_menu: CenterContainer = $PauseMenu
@onready var unpause_button: Button = $PauseMenu/VBoxContainer/UnPauseButton
@onready var pause_title_button: Button = $PauseMenu/VBoxContainer/TitleButton

# Game over menu
@onready var game_over_menu: CenterContainer = $GameOverMenu
@onready var retry_button: Button = $GameOverMenu/VBoxContainer/RetryButton
@onready var go_title_button: Button = $GameOverMenu/VBoxContainer/TitleButton


func _ready():
	round_tracker.text = "Round: 1"
	score_tracker.text = "Score: 0"
	
	# Pause menu
	unpause_button.pressed.connect(_unpause)
	pause_title_button.pressed.connect(_go_title)
	pause_menu.hide()
	
	# Game over menu
	retry_button.pressed.connect(_retry)
	go_title_button.pressed.connect(_go_title)
	game_over_menu.hide()


func set_max_values(health: float, bullets:float, beam: float, slash: float, dash:float, shield: float):
	health_bar.max_value = health
	gun_bar.max_value = bullets
	beam_bar.max_value = beam
	slash_bar.max_value = slash
	dash_bar.max_value = dash
	shield_bar.max_value = shield


func update_display(
	health: float, 
	bullet_count: int, 
	reloading: bool,
	beam_val: float, 
	beam_full_refil: bool, 
	slash_val: float, 
	slash_refilling: bool,
	dash_val: float, 
	dash_refilling: bool,
	shield_val: float,
	shield_full_refil: bool
):
	health_bar.value = health
	
	gun_bar.value = bullet_count
	if reloading:
		gun_bar.tint_progress = Color(gun_colour, 0.502)
	else:
		gun_bar.tint_progress = gun_colour
	
	beam_bar.value = beam_val
	if beam_full_refil:
		beam_bar.tint_progress = Color(beam_colour, 0.502)
	else:
		beam_bar.tint_progress = beam_colour
	
	slash_bar.value = slash_val
	if slash_refilling:
		slash_bar.tint_progress = Color(slash_colour, 0.502)
	else:
		slash_bar.tint_progress = slash_colour
	
	dash_bar.value = dash_val
	if dash_refilling:
		dash_bar.tint_progress = Color(dash_colour, 0.502)
	else:
		dash_bar.tint_progress = dash_colour
	
	shield_bar.value = shield_val
	if shield_full_refil:
		shield_bar.tint_progress = Color(shield_colour, 0.502)
	else:
		shield_bar.tint_progress = shield_colour


func update_score(new_score: int):
	score_tracker.text = "Score: %s" % str(score + new_score)


func _on_test_round_change(new_round: int):
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
	# Unpause to avoid getting stuck
	get_tree().paused = false
	get_tree().reload_current_scene()

func _go_title():
	# Has to unpause otherwise gets stuck on title screen
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title/title_screen.tscn")
