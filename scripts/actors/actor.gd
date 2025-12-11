@abstract class_name Actor extends Entity
# Has a value that can be read by conditions

signal now_true
signal now_false
signal changed_to(to:bool)

var value:bool = false

func set_value(to:bool) -> bool:
	if to == value: return false
	
	value = to
	
	if to: 
		_on_true()
		now_true.emit()
	else:
		_on_false()
		now_false.emit()
	_on_change(to)
	changed_to.emit(to)
	
	return true

func _on_true() -> void: pass
func _on_false() -> void: pass
func _on_change(_to:bool) -> void: pass
