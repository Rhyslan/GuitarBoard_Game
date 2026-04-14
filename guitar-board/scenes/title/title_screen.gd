extends MarginContainer

@onready var play_button := $VBoxContainer/HBoxContainer/CenterContainer/PlayButton
@onready var quit_button := $VBoxContainer/HBoxContainer/CenterContainer2/QuitButton


func _ready():
	play_button.pressed.connect(_play_pressed)
	quit_button.pressed.connect(_quit_pressed)


func _play_pressed():
	get_tree().change_scene_to_file("res://scenes/test/test.tscn")

 
func _quit_pressed():
	get_tree().quit()
