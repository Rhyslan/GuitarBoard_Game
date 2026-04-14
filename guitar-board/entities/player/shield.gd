class_name Shield extends StaticBody2D

@onready var collision_shape := $CollisionShape2D
var is_active := false

func _ready() -> void:
	collision_shape.disabled = true


func activate():
	visible = true
	collision_shape.disabled = false
	is_active = true


func deactivate():
	visible = false
	collision_shape.disabled = true
	is_active = false
