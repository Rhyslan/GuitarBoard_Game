extends CharacterBody2D


@export var Bullet : PackedScene

# Movement
@export var speed = 400.0
@export var rot_speed = 5.0
var rot_vel = 0
var health = 100

# Actions
var selectedActions = {
	"gun": false, 
	"beam": false, 
	"slash": false, 
	"dash": false, 
	"shield": false
}
@export var gun_amount = 25
@export var beam_amount = 50
@export var beam_deplete_rate = 5
@export var beam_refill_rate = 2
@export var slash_cooldown = 5
@export var dash_cooldown = 2
@export var shield_amount = 20
@export var shield_deplete_rate = 5
@export var shield_refill_rate = 2

@onready var slash_area = $Slash

func get_input():
	# Rotation
	rot_vel = Input.get_axis("Spin Left", "Spin Right")
	rotation += deg_to_rad(rot_vel * rot_speed)

	# Movement
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_dir * speed
	
	# Actions
	selectedActions["gun"] = Input.is_action_pressed("Gun")
	selectedActions["beam"] = Input.is_action_pressed("Beam")
	selectedActions["slash"] = Input.is_action_pressed("Slash")
	selectedActions["dash"] = Input.is_action_pressed("Dash")
	selectedActions["shield"] = Input.is_action_pressed("Shield")
	if Input.is_action_just_pressed("Jump"):
		jump()
	if Input.is_action_just_pressed("Reload"):
		reload()
	
	if Input.is_action_just_pressed("Attack"):
		if selectedActions["gun"]:
			gun()
		if selectedActions["slash"]:
			slash()
		if selectedActions["dash"]:
			dash()
	if Input.is_action_pressed("Attack"):
		if selectedActions["beam"]:
			beam()
		if selectedActions["shield"]:
			shield()

func jump():
	print("jumped")


func gun():
	var b = Bullet.instantiate()
	self.get_parent().add_child(b)
	b.transform = $AttackSpawn.global_transform


func beam():
	print("holding beam")


func slash():
	slash_area.visible = true
	get_tree().create_timer(0.1).timeout.connect(func(): slash_area.visible = false)
	


func dash():
	print("dashed")


func shield():
	print("holding shield")


func reload():
	print("Starting reload")



func get_hit(health_lost):
	health-=health_lost
	
	if health <= 0:
		game_over()
		

#game over (temp)
func game_over():
	health = 0
	print("Game Over!")
	
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	#everything the player hits
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collision.get_collider().name == "Mob":
			get_hit(2)
	
