class_name Camera extends Camera2D

func _init() -> void: Global.camera = self

@export var shake_deterioration = 1.1
@export var lerp_amount := 0.1

@onready var target := Global.player

@onready var real_position := global_position
@export var shake := Vector2.ZERO
@export var shake_time := 0.0

func get_next_position(_delta) -> Vector2:

	var a = real_position
	var b = target.global_position + (0.3 * target.velocity)
	
	var x = lerp(a.x, b.x, 0.1)
	var y = a.y #lerp(global_position.y, target.global_position.y, lerp_amount)
	
	#if abs(a.x - b.x) > 50.0:
		#x = lerp(a.x, b.x, 1/50.0)
	
	return Vector2(x,y)

func camshake(amnt:float, time:float):
	shake = Vector2(amnt, amnt)
	shake_time = time
func get_next_shake() -> Vector2:
	var abs_shake = Vector2(abs(shake.x), abs(shake.y))
	
	if shake_time <= 0:
		abs_shake /= shake_deterioration
	
	return Vector2([-1, 1].pick_random() * abs_shake.x, [-1, 1].pick_random() * abs_shake.y)

func _process(delta: float) -> void:
	shake_time = move_toward(shake_time, 0, delta)
	shake = get_next_shake()
	
	real_position = get_next_position(delta)
	
	global_position = real_position + shake
