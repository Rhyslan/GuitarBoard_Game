extends RayCast2D

@export var cast_speed := 7000.0
@export var max_length := 1400.0
@export var start_distance := 40.0
@export var growth_time := 0.1
@export var is_casting := false: set = set_is_casting

var tween: Tween = null

@onready var line: Line2D = $Line2D
@onready var line_width := line.width

func _ready() -> void:
	set_is_casting(is_casting)
	line.points[0] = Vector2.RIGHT * start_distance
	line.points[1] = Vector2.ZERO
	line.visible = false
	
	if not Engine.is_editor_hint():
		set_physics_process(false)

func _physics_process(delta: float) -> void:
	target_position = target_position.move_toward(Vector2.UP * max_length, cast_speed * delta)
	
	var end_pos := target_position
	force_raycast_update()
	
	if is_colliding():
		end_pos = to_local(get_collision_point())
	
	line.points[1] = end_pos

func set_is_casting(new_val: bool):
	if is_casting == new_val:
		return
		
	if new_val == false:
		print("not")
	is_casting = new_val
	
	set_physics_process(is_casting)
	
	if not line:
		return
	
	if is_casting:
		var start := Vector2.UP * start_distance
		line.points[0] = start
		line.points[1] = start
		
		appear()
	else:
		target_position = Vector2.ZERO
		disappear()


func appear() -> void:
	line.visible = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line, "width", line_width, growth_time * 2).from(0.0)


func disappear() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line, "width", 0.0, growth_time * 2).from_current()
	tween.tween_callback(line.hide)
