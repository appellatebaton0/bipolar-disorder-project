extends Node

signal became_manic
signal became_depressed
signal became_normal

signal became_not_manic
signal became_not_depressed
signal became_not_normal

signal changed_state(from:STATES, to:STATES)


enum STATES {MANIC, DEPRESSIVE, NORMAL}
var player_state := STATES.NORMAL

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Mania"): state_to(STATES.MANIC)
	if Input.is_action_just_pressed("Depress"): state_to(STATES.DEPRESSIVE)

func state_to(to:STATES):
	var from = to
	
	if to == player_state: return
	
	match player_state:
		STATES.MANIC: became_not_manic.emit()
		STATES.DEPRESSIVE: became_not_depressed.emit()
		STATES.NORMAL: became_not_normal.emit()
	
	player_state = to
	
	match to:
		STATES.MANIC: became_manic.emit()
		STATES.DEPRESSIVE: became_depressed.emit()
		STATES.NORMAL: became_normal.emit()
	
	changed_state.emit(from, to)
