extends Node

signal became_manic
signal became_depressed
signal became_normal

enum STATES {MANIC, DEPRESSIVE, NORMAL}
var player_state := STATES.NORMAL

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Mania"): state_to(STATES.MANIC)
	if Input.is_action_just_pressed("Depress"): state_to(STATES.DEPRESSIVE)

func state_to(to:STATES):
	player_state = to
	
	match to:
		STATES.MANIC: became_manic.emit()
		STATES.DEPRESSIVE: became_depressed.emit()
		STATES.NORMAL: became_normal.emit()
