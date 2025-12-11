class_name LevelBox extends GridContainer

var button_scene := load("res://scenes/level_button.tscn")

func _ready() -> void:
	for level in LevelManager.levels:
		var new:LevelButton = button_scene.instantiate()
		
		new.level_id = level.id
		
		add_child(new)
	
	columns = ceil(sqrt(len(LevelManager.levels)))
