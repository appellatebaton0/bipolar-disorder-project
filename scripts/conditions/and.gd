class_name AND extends Condition

@export var inputs:Array[Condition]

func _ready() -> void:
	for child in get_children():
		if child is Condition and not inputs.has(child): inputs.append(child)

func value() -> bool:
	
	for input in inputs:
		if not input.value(): return false
	
	return true
