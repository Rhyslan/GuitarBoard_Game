class_name GameUI extends Control

# Resource variables
@onready var health_bar: TextureProgressBar = $Resources/VBoxContainer/HealthBar
@onready var ammo_count: Label = $Resources/VBoxContainer/HBoxGunSlash/Ammo
@onready var beam_bar: TextureProgressBar = $Resources/VBoxContainer/HBoxBeamShield/BeamBar
@onready var slash_cd: Label = $Resources/VBoxContainer/HBoxGunSlash/SlashCD
@onready var shield_bar: TextureProgressBar = $Resources/VBoxContainer/HBoxBeamShield/ShieldBar

# Round and Score variables
@onready var round_tracker: Label = $RoundScore/VBoxContainer/Round
@onready var score_tracker: Label = $RoundScore/VBoxContainer/Score

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
	
	# Pause menu
	unpause_button.pressed.connect(_unpause)
	pause_title_button.pressed.connect(_go_title)
	pause_menu.hide()
	
	# Game over menu
	retry_button.pressed.connect(_retry)
	go_title_button.pressed.connect(_go_title)
	game_over_menu.hide()


# TODO: Change UI values to match game values, i.e. health_bar.value = Player Health
#func _process(delta):
#	pass


func set_max_values(health: float, beam: float, shield: float):
	health_bar.max_value = health
	beam_bar.max_value = beam
	shield_bar.max_value = shield


func update_display(health: float, bullet_count: int, beam_value: float, shield_value: float, slash_val: int):
	health_bar.value = health
	ammo_count.text = "Ammo: %s" % str(bullet_count)
	beam_bar.value = beam_value
	shield_bar.value = shield_value
	slash_cd.text = "Slash CD: %s" % str(slash_val)


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
	get_tree().paused = false
	get_tree().reload_current_scene()

func _go_title():
	# Has to unpause otherwise gets stuck on title screen
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title/title_screen.tscn")
