class_name Level extends Node

func _init() -> void: Global.level = self

@export var antidepressants := 0
@export var depressants := 0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Mania") and antidepressants > 0: 
		PlayerState.state_to(PlayerState.STATES.MANIC)
	if Input.is_action_just_pressed("Depress") and depressants > 0: 
		PlayerState.state_to(PlayerState.STATES.DEPRESSIVE)
