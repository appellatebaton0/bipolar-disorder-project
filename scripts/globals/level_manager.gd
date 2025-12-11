extends Node

signal level_index_update(to:int)

const LEVEL_PATH := "res://scenes/levels/"

var level_index := 0
var current_level:LevelData

@onready var levels:Array[LevelData] = get_levels()
func get_levels(path := LEVEL_PATH) -> Array[LevelData]:
	
	var response:Array[LevelData]
	
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			
			file_name = file_name.replace(".remap", "")
			
			if dir.current_is_dir(): response.append_array(get_levels(path + file_name + "/")) # Add subdirectories
			else: response.append(LevelData.new(load(path + file_name), file_name)) # Add found lvls
			
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	# Sort by the names of the files.
	var real = merge_sort(response, _by_name)
	for i in len(real): response[i] = real[i]
	
	# Set the file ids.
	for i in len(response): response[i].id = i
	
	return response

class LevelData:
	var id:int
	var scene:PackedScene
	var filename:String
	var instance:Node
	
	func _init(set_scene:PackedScene, set_filename:String, set_id := -1) -> void:
		scene = set_scene
		filename = set_filename
		id = set_id

func merge_sort(array:Array, condition:Callable) -> Array:
	
	var length = len(array)
	
	if length <= 1: return array
	
	@warning_ignore("integer_division")
	var left = array.slice(0, floor((length + 1) / 2))
	@warning_ignore("integer_division")
	var right = array.slice(floor((length + 1) / 2), length)
	
	
	left  = merge_sort(left,  condition)
	right = merge_sort(right, condition)
	
	# The array's already sorted.
	if   len(left)  <= 0: return right 
	elif len(right) <= 0: return left 
	
	var li = 0
	var ri = 0
	
	var response:Array

	while len(response) < len(left) + len(right):
		
		# One of the arrays is empty; append the other and end.
		if li >= len(left): 
			response.append_array(right.slice(ri))
			break
		elif ri >= len(right):
			response.append_array(left.slice(li))
			break
		
		# Otherwise, append the next.
		if condition.call(left[li], right[ri]): 
			response.append(right[ri])
			ri += 1
		else:
			response.append(left[li])
			li += 1
	
	return response

func _by_name(a:LevelData, b:LevelData) -> bool:
	var sorted = [a.filename, b.filename]
	sorted.sort()
	return sorted != [a.filename, b.filename]

func set_level_index_to(to:int):
	if to < level_index: return
	
	level_index = to
	
	level_index_update.emit(to)
