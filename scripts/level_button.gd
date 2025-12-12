class_name LevelButton extends PanelContainer

@onready var main := Global.main
@onready var anim := Global.animator
@onready var button := $MarginContainer/Button

var level_id:int

func _ready() -> void:
	button.text = str(level_id + 1)
	
	LevelManager.level_index_update.connect(_on_level_index_update)
	_on_level_index_update(LevelManager.level_index)

func _on_pressed() -> void:
	
	var new = LevelManager.levels[level_id].scene.instantiate()
	
	main.add_child(new)
	
	LevelManager.levels[level_id].instance = new
	
	LevelManager.current_level = LevelManager.levels[level_id]
	
	LevelManager.set_level_index_to(level_id)
	
	anim.play("levels_to_game")

func _on_level_index_update(to:int):
	button.disabled = to < level_id
