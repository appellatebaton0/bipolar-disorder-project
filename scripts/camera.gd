class_name Camera extends Camera2D

@export var lerp_amount := 0.1

@onready var target := Global.player

@onready var real_position := global_position
@onready var shake := Vector2(10,10)

func get_next_position(_delta) -> Vector2:
	
	var a = real_position
	var b = target.global_position
	
	var x = a.x
	var y = a.y #lerp(global_position.y, target.global_position.y, lerp_amount)
	
	if abs(a.x - b.x) > 50.0:
		x = lerp(a.x, b.x, 1/50.0)
	
	return Vector2(x,y)

func _process(delta: float) -> void:
	shake = Vector2(randf_range(-16,16),randf_range(-16,16))
	
	real_position = get_next_position(delta)
	
	global_position = real_position + shake
