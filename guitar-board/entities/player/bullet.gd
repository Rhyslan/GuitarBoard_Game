class_name Bullet extends Area2D

@export var speed := 750


func _physics_process(delta: float) -> void:
	position -= transform.y * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		body.take_damage(1)
		queue_free()
