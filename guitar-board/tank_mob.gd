extends Mob #inherit mob stats

@export_category("Charge Mechanics")
@export var idle_time := 3.0      
@export var windup_time := 0.8    
@export var charge_duration := 1.2 
@export var charge_speed := 500.0  

#Created a State Machine for the boss
enum State { IDLE, WINDUP, CHARGE }
var current_state = State.IDLE

var state_timer := idle_time
var locked_direction := Vector2.ZERO

func _physics_process(delta: float):
	state_timer -= delta
	look_at(player.global_position)
	
	match current_state:
		State.IDLE:
			velocity = Vector2.ZERO
			if state_timer <= 0.0:
				enter_windup()
				
		State.WINDUP:
			velocity = Vector2.ZERO
			if state_timer <= 0.0:
				enter_charge()
				
		State.CHARGE:
			# No tracking
			velocity = locked_direction * charge_speed
			if state_timer <= 0.0:
				enter_idle()

	# Inherited physics from Mob
	velocity += knockback_vel
	move_and_slide()

func enter_windup():
	current_state = State.WINDUP
	state_timer = windup_time
	
	# Visual Telegraph
	modulate = Color.RED 

func enter_charge():
	current_state = State.CHARGE
	state_timer = charge_duration
	modulate = Color.WHITE
	
	#locked trajectory
	locked_direction = global_position.direction_to(player.global_position)

func enter_idle():
	current_state = State.IDLE
	state_timer = idle_time
