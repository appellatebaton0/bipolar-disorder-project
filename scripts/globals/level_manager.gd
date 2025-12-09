extends Node

const LEVEL_PATH := "res://scenes/levels/"

var current_level:Level

@onready var levels:Array[Level] = get_levels()
func get_levels(path := LEVEL_PATH) -> Array[Level]:
	
	var response:Array[Level]
	
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			
			file_name = file_name.replace(".remap", "")
			
			if dir.current_is_dir(): response.append_array(get_levels(path + file_name + "/")) # Add subdirectories
			else: response.append(Level.new(load(path + file_name), file_name)) # Add found lvls
			
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	# Sort by the names of the files.
	response.sort_custom(_by_id)
	
	for i in response: print(i.filename)

	return response

class Level:
	var id:int
	var scene:PackedScene
	var filename:String
	var instance:Node
	
	func _init(set_scene:PackedScene, set_filename:String, set_id := -1) -> void:
		scene = set_scene
		filename = set_filename
		id = set_id

func _by_id(a:Level, b:Level) -> bool:
	return a.id > b.id
