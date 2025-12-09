class_name LevelBox extends GridContainer

var button_scene := load("res://scenes/level_button.tscn")

func _ready() -> void:
	for level in LevelManager.levels:
		print("made new")
		var new = button_scene.instantiate()
		
		new.level = level
		
		add_child(new)
	
	columns = ceil(sqrt(len(LevelManager.levels)))
