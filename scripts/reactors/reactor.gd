@abstract class_name Reactor extends Entity
# Has built-ins for when a provided condition changes states.

@export var condition:Condition
var current_value:bool

func _ready() -> void:
	if condition == null: for child in get_children(): if child is Condition:
		condition = child
		break
	if condition == null: 
		var parent = get_parent()
		if parent is Condition: condition = parent
	
	if condition != null:
		condition.switched.connect(_on_switch)
	
		if condition.value(): _on_true()
		else: _on_false()
		_on_switch(condition.value())
	else: push_error(self, " is missing a condition.")
	_once_ready()
	
func _process(delta: float) -> void:
	if condition != null:
		if condition.value(): _while_true(delta)
		else: _while_false(delta)
	_active(delta)

func _on_switch(to:bool):
	current_value = to
	
	if to: _on_true() 
	else: _on_false()

func _once_ready() -> void: pass

func _while_true(_delta:float) -> void: pass
func _while_false(_delta:float) -> void: pass

func _on_true() -> void: pass
func _on_false() -> void: pass

func _active(_delta:float) -> void: pass
