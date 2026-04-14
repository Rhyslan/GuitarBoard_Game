class_name Player extends CharacterBody2D


signal pause_pressed()
signal game_over_signal()

@export var ui: GameUI
@export var max_health := 100.0

@export_category("Movement")
@export var speed := 400.0
@export var rot_speed := 5.0

@export_category("Actions")
@export var max_bullet_count := 25
@export var max_beam_amount := 100
@export var beam_deplete_rate := 5
@export var beam_refill_rate := 2
@export var slash_cooldown := 5
@export var dash_cooldown := 2
@export var max_shield_amount := 100
@export var shield_deplete_rate := 5
@export var shield_refill_rate := 2

var rot_vel := 0.0
var selectedActions := {
	"gun": false, 
	"beam": false, 
	"slash": false, 
	"dash": false, 
	"shield": false
}

var reloading := false
var beam_state := "refil"

@onready var bullets_remaining: float = max_bullet_count
@onready var beam_remaining: float = max_beam_amount
@onready var shield_remaining: float = max_shield_amount
@onready var bullet := preload("res://entities/player/bullet.tscn")
@onready var beam := $Beam
@onready var slash := $Slash
@onready var attack_spawn := $AttackSpawn
@onready var health := max_health


func _ready() -> void:
	ui.set_max_values(max_health, max_shield_amount, max_beam_amount)


func _physics_process(delta: float) -> void:
	ui.update_display(round(health), round(bullets_remaining), beam_remaining, shield_remaining, slash_cooldown)
	get_input(delta)
	move_and_slide()
	
	if reloading:
		if bullets_remaining < max_bullet_count:
			bullets_remaining += 5 * delta
		
		if bullets_remaining >= max_bullet_count:
			reloading = false
	
	#everything the player hits
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.get_class() == "CharacterBody2D":
				if (collider as CharacterBody2D).is_in_group("mobs"):
					get_hit(collider.dmg_per_sec * delta)


func get_input(delta: float):
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
		reloading = true
	
	if Input.is_action_just_pressed("Attack"):
		if selectedActions["gun"]:
			shoot()
		if selectedActions["slash"]:
			do_slash()
		if selectedActions["dash"]:
			dash()
	
	if Input.is_action_pressed("Attack"):
		if selectedActions["beam"]:
			beam.set_is_casting(true)
			beam_deplete(delta)
		else:
			beam.set_is_casting(false)
			beam_refil(delta)
		
		if selectedActions["shield"]:
			shield()
	else:
		beam.set_is_casting(false)
		beam_refil(delta)
	
	# Pause
	if Input.is_action_just_pressed("Pause"):
		pause_pressed.emit()

func jump():
	print("jumped")


func shoot():
	if bullets_remaining > 0 and not reloading:
		var b = bullet.instantiate()
		self.get_parent().add_child(b)
		b.transform = attack_spawn.global_transform
		bullets_remaining -= 1
		
		if bullets_remaining < 0:
			bullets_remaining = 0
	elif reloading:
		# Put currently reloading warning here
		print("currently reloading")
	else:
		# Put reload warning here
		print("need to reload")


func beam_deplete(delta: float):
	if beam_remaining > 0.0 and beam.is_casting:
		beam_remaining -= beam_deplete_rate * delta
		
		if beam_remaining < 0.0:
			beam_remaining = 0.0


func beam_refil(delta: float):
	if beam_remaining <= max_beam_amount and not beam.is_casting:
		beam_remaining += beam_refill_rate * delta
		
		if beam_remaining > max_beam_amount:
			beam_remaining = max_beam_amount


func do_slash():
	slash.attack()


func dash():
	print("dashed")


func shield():
	print("holding shield")


func get_hit(health_lost: float):
	health -= health_lost
	
	print(health)
	
	if health <= 0:
		game_over()
		


#game over (temp)
func game_over():
	health = 0
	game_over_signal.emit()
