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


func _ready():
	round_tracker.text = "Round: 1"


# TODO: Change UI values to match game values, i.e. health_bar.value = Player Health
#func _process(delta):
#	pass


func _on_test_round_change(new_round: int):
	round_tracker.text = "Round: " + str(new_round)


func set_max_values(health: float, beam: float, shield: float):
	health_bar.max_value = health
	beam_bar.max_value = beam
	shield_bar.max_value = shield


func update_display(health: int, bullet_count: int, beam_value: float, shield_value: float, slash_val: int):
	health_bar.value = health
	ammo_count.text = "Ammo: %s" % str(bullet_count)
	beam_bar.value = beam_value
	shield_bar.value = shield_value
	slash_cd.text = "Slash CD: %s" % str(slash_val)
