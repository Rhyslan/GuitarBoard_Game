extends Timer

var round
# Called when the node enters the scene tree for the first time.
func _ready():
	round = 1
	wait_time = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_round_change(new_round):
	round = new_round
	if (11 - round) >= 1:
		wait_time = 11 - round
	else:
		wait_time = 0.5
