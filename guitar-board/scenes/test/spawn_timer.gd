class_name SpawnTimer extends Timer

@onready var round_num := 1


func _ready():
	wait_time = 10


#func _process(_delta: float):
#	pass

func _on_round_change(new_round: int):
	round_num = new_round
	if (11 - round_num) >= 1:
		wait_time = 11 - round_num
	else:
		wait_time = 0.5
