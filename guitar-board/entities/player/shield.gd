class_name Shield extends StaticBody2D

@export var max_radius := 1.5
var is_active := false

@onready var collision_shape := $CollisionShape2D


func _ready() -> void:
	collision_shape.disabled = true


func _physics_process(delta: float) -> void:
	if is_active:
		if scale.x < max_radius:
			scale += Vector2.ONE * 10 * delta
	else:
		scale = Vector2.ZERO


func activate():
	visible = true
	collision_shape.disabled = false
	is_active = true


func deactivate():
	visible = false
	collision_shape.disabled = true
	is_active = false
