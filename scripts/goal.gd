class_name Goal extends Area2D

@onready var anim := Global.animator

func _on_body_entered(_body: Node2D) -> void:
	anim.play("game_to_levels")
	
	LevelManager.set_level_index_to(LevelManager.current_level.id + 1)
