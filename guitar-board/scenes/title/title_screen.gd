extends MarginContainer

var play_button
var quit_button

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button = get_node("VBoxContainer/HBoxContainer/CenterContainer/PlayButton")
	quit_button = get_node("VBoxContainer/HBoxContainer/CenterContainer2/QuitButton")
	
	play_button.pressed.connect(_play_pressed)
	quit_button.pressed.connect(_quit_pressed)

func _play_pressed():
	get_tree().change_scene_to_file("res://scenes/test/test.tscn")

func _quit_pressed():
	get_tree().quit()
	
