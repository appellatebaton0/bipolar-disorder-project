class_name Goal extends Area2D
# E, o

@onready var anim := Global.animator

func _on_body_entered(_body: Node2D) -> void:
	anim.play("game_to_levels")
