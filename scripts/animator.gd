extends AnimationPlayer

func _init() -> void: Global.animator = self



func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"game_to_levels":
			LevelManager.current_level.instance.queue_free()
			PlayerState.state_to(PlayerState.STATES.NORMAL)
