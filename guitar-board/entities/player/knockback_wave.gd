class_name KnockbackWave extends Area2D

@export var max_radius := 5.0
@export var growth_speed := 5.0
@export var knockback_force := 500.0

var is_active := false
var tween: Tween = null
var tween2: Tween = null

@onready var collision_shape: CircleShape2D = $CollisionShape2D.shape
@onready var radius := collision_shape.radius


func _physics_process(delta: float) -> void:
	if is_active:
		scale += Vector2.ONE * growth_speed * delta
		
		if scale.x >= max_radius:
			stop()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		var dir = (body.global_position - global_position).normalized()
		(body as Mob).apply_knockback(dir * knockback_force)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		(body as Mob).remove_knockback()


func start():
	is_active = true
	visible = true


func stop():
	is_active = false
	visible = false
	scale = Vector2.ONE
