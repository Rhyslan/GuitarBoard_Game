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

# TODO: Change UI values to match game values, i.e. health_bar.value = Player Health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_test_round_change(new_round):
	round_tracker.text = "Round: " + str(new_round)
