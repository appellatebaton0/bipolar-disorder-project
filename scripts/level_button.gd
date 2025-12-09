class_name LevelButton extends PanelContainer

@onready var main := Global.main
@onready var anim := Global.animator
@onready var button := $MarginContainer/Button

var level:LevelManager.Level


func _on_pressed() -> void:
	
	var new = level.scene.instantiate()
	
	main.add_child(new)
	
	var new_level = LevelManager.Level.new(level.scene, level.filename)
	new_level.instance = new
	LevelManager.current_level = new_level
	
	anim.play("levels_to_game")
	
	pass
