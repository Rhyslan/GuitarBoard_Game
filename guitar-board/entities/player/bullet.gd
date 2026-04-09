extends Area2D

@export var speed = 750

func _physics_process(delta: float) -> void:
	position -= transform.y * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		body.queue_free()
	#queue_free()
