extends Area2D

@export var speed := 500.0
var direction := Vector2.ZERO

func _physics_process(delta: float):
	#Propel projectile
	position += direction * speed * delta
	
func _on_body_entered(body: Node2D):
	if body.name == "Player":
		body.get_hit(1.0)
		queue_free()
	#Destroy Projectile once it hits player
	
