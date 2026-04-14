class_name Slash extends Area2D

var mobs := []

func _physics_process(_delta: float) -> void:
	if visible and len(mobs) > 0:
		for mob in mobs:
			mob.take_damage(3)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		mobs.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		mobs.erase(body)


func attack():
	visible = true
	get_tree().create_timer(0.1).timeout.connect(func(): visible = false)
