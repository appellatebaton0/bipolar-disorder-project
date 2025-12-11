class_name OR extends Condition

@export var inputs:Array[Condition]

func _ready() -> void:
	for child in get_children():
		if child is Condition and not inputs.has(child): inputs.append(child)

func value() -> bool:
	
	for input in inputs:
		if input.value(): return true
	
	return false
