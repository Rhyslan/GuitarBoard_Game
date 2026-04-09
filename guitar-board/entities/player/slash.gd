extends Area2D


var mobs = []


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		mobs.append(body)

func _physics_process(delta: float) -> void:
	if visible and len(mobs) > 0:
		for mob in mobs:
			mob.queue_free()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		mobs.erase(body)
