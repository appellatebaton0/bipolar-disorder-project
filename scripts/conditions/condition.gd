@abstract class_name Condition extends Node
## Returns a value, and emits a signal when that value changes.

signal switched(to:bool)

var last_value:bool

func _process(_delta:float):
	var next_value  = value()
	if next_value != last_value:
		switched.emit(next_value)
		last_value = next_value

func value() -> bool: return false
