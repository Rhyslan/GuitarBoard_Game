class_name Player extends CharacterBody2D

signal pause_pressed()
signal game_over_signal()

@export var ui: GameUI
@export var max_health := 100.0

@export_category("Movement")
@export var speed := 400.0
@export var rot_speed := 5.0

@export_category("Actions")
@export_group("Gun")
@export var max_bullet_count := 25
@export_group("Beam")
@export var max_beam_amount := 100
@export var beam_deplete_rate := 20
@export var beam_refill_rate := 5
@export_group("Slash")
@export var max_slash_cooldown := 5.0
@export var slash_cd_speed := 5.0
@export_group("Dash")
@export var max_dash_cooldown := 2.0
@export var dash_cd_speed := 5.0
@export var dash_speed_multiplier := 2.0
@export_group("Shield")
@export var max_shield_amount := 100
@export var shield_deplete_rate := 50
@export var shield_refill_rate := 5

var rot_vel := 0.0
var selectedActions := {
	"gun": false, 
	"beam": false, 
	"slash": false, 
	"dash": false, 
	"shield": false
}

var is_reloading := false
var is_beam_refilling := false
var is_slash_cooldown := false
var is_dashing := false
var is_dash_cooldown := false
var is_shield_refilling := false

@onready var bullets_remaining: float = max_bullet_count
@onready var beam_remaining: float = max_beam_amount
@onready var shield_remaining: float = max_shield_amount
@onready var bullet := preload("res://entities/player/bullet.tscn")
@onready var beam: Beam = $Beam
@onready var slash: Slash = $Slash
@onready var attack_spawn: Marker2D = $AttackSpawn
@onready var knockback_wave: KnockbackWave = $KnockbackWave
@onready var shield: Shield = $Shield
@onready var health := max_health
@onready var slash_cooldown := max_slash_cooldown
@onready var dash_cooldown := max_dash_cooldown


func _ready() -> void:
	ui.set_max_values(max_health, max_bullet_count, max_beam_amount, max_slash_cooldown, max_dash_cooldown, max_shield_amount)


func _physics_process(delta: float) -> void:
	ui.update_display(
		round(health),
		round(bullets_remaining), 
		beam_remaining, 
		is_beam_refilling, 
		round(slash_cooldown),
		round(dash_cooldown),
		shield_remaining,
		is_shield_refilling
	)
	get_input(delta)
	move_and_slide()
	
	reload(delta)
	cooldown_slash(delta)
	
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
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	if is_dashing:
		velocity = (input_dir * speed) * dash_speed_multiplier
	else:
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
		is_reloading = true
	
	if Input.is_action_just_pressed("Attack"):
		if selectedActions["gun"]:
			shoot()
		if selectedActions["slash"]:
			do_slash()
		if selectedActions["dash"]:
			dash()
	
	if Input.is_action_pressed("Attack"):
		if selectedActions["beam"]:
			if not is_beam_refilling:
				beam_on(delta)
			else:
				beam_off(delta)
		else:
			beam_off(delta)
		
		if selectedActions["shield"]:
			if not is_shield_refilling:
				shield_on(delta)
			else:
				shield_off(delta)
		else:
			shield_off(delta)
	else:
		beam_off(delta)
		shield_off(delta)
	
	# Pause
	if Input.is_action_just_pressed("Pause"):
		pause_pressed.emit()

func jump():
	if not knockback_wave.is_active:
		knockback_wave.start()


func shoot():
	if bullets_remaining > 0 and not is_reloading:
		var b = bullet.instantiate()
		self.get_parent().add_child(b)
		b.transform = attack_spawn.global_transform
		bullets_remaining -= 1
		
		if bullets_remaining < 0:
			bullets_remaining = 0
	elif is_reloading:
		# Put currently reloading warning here
		print("currently reloading")
	else:
		# Put reload warning here
		print("need to reload")


func reload(delta: float):
	if is_reloading:
		if bullets_remaining < max_bullet_count:
			bullets_remaining += 5 * delta
		
		if bullets_remaining >= max_bullet_count:
			is_reloading = false


func beam_on(delta: float):
	beam.set_is_casting(true)
	beam_deplete(delta)


func beam_off(delta: float):
	beam.set_is_casting(false)
	beam_refil(delta)


func beam_deplete(delta: float):
	if beam_remaining > 0.0 and beam.is_casting:
		beam_remaining -= beam_deplete_rate * delta
		
		if beam_remaining < 0.0:
			beam_remaining = 0.0
			is_beam_refilling = true


func beam_refil(delta: float):
	if beam_remaining <= max_beam_amount and not beam.is_casting:
		beam_remaining += beam_refill_rate * delta
		
		if beam_remaining > max_beam_amount:
			beam_remaining = max_beam_amount
			is_beam_refilling = false


func do_slash():
	if not is_slash_cooldown:
		slash.attack()
		is_slash_cooldown = true


func cooldown_slash(delta: float):
	if is_slash_cooldown:
		if slash_cooldown > 0:
			slash_cooldown -= slash_cd_speed * delta
		
		if slash_cooldown <= 0:
			is_slash_cooldown = false
			slash_cooldown = max_slash_cooldown


func dash():
	if not is_dash_cooldown:
		is_dashing = true
		get_tree().create_timer(0.5).timeout.connect(func(): is_dashing = false)


func cooldown_dash(delta: float):
	if is_dash_cooldown:
		if dash_cooldown > 0:
			dash_cooldown -= dash_cd_speed * delta
		
		if dash_cooldown <= 0:
			is_dash_cooldown = false
			dash_cooldown = max_dash_cooldown


func shield_on(delta: float):
	shield.activate()
	shield_deplete(delta)


func shield_off(delta: float):
	shield.deactivate()
	shield_refil(delta)


func shield_deplete(delta: float):
	if shield_remaining > 0.0 and shield.is_active:
		shield_remaining -= shield_deplete_rate * delta
		
		if shield_remaining < 0.0:
			shield_remaining = 0.0
			is_shield_refilling = true


func shield_refil(delta: float):
	if shield_remaining <= max_shield_amount and not shield.is_active:
		shield_remaining += shield_refill_rate * delta
		
		if shield_remaining > max_shield_amount:
			shield_remaining = max_shield_amount
			is_shield_refilling = false


func get_hit(health_lost: float):
	health -= health_lost
	
	if health <= 0:
		game_over_signal.emit()
