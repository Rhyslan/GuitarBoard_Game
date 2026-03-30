extends Node2D

var input_list = "Actions pressed:\n"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	$CanvasLayer/UI/Label.text = input_list
