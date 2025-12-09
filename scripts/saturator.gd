class_name Saturator extends TextureRect

@export var change_speed := 1.0

func _process(delta: float) -> void: if material is ShaderMaterial:
	
	var saturation = material.get_shader_parameter("saturation")
	
	match PlayerState.player_state:
		PlayerState.STATES.MANIC:      saturation = move_toward(saturation, 1.6, delta * change_speed)
		PlayerState.STATES.DEPRESSIVE: saturation = move_toward(saturation, 0.6, delta * change_speed)
		PlayerState.STATES.NORMAL:     saturation = move_toward(saturation, 1.0, delta * change_speed)
	
	material.set_shader_parameter("saturation", saturation)
