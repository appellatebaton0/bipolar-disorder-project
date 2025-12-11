class_name ButtonActor extends Actor


@export var timeout := 1.0
var timer := 0.0

@onready var area := get_area()
func get_area() -> Area2D:
	var me = self
	return me

func _process(delta: float) -> void:
	if area.has_overlapping_bodies():
		value = true
		timer = timeout
	elif timer <= 0: value = false
	else: timer = move_toward(timer, 0, delta)
