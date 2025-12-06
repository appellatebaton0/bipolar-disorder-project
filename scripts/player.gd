class_name Player extends CharacterBody2D

# Stores data for horizontal movement
class move_data:
	var max_speed := 30.0
	var acceleration := 300.0
	var friction := 300.0
	
	func _init(set_max_speed := max_speed, set_acceleration := acceleration, set_friction := friction) -> void:
		max_speed = set_max_speed
		acceleration = set_acceleration
		friction = set_friction
# Stores data for all movement
class control_data:
	var coyote_time := 0.1
	var jump_buffer := 0.1
	
	var gravity := 1.0
	var jump_velocity := 300.0
	
	var ground := move_data.new()
	var air := move_data.new()
	
	func _init(set_ground := ground, set_air := air, set_jump := jump_velocity, set_grav := gravity, set_coyote := coyote_time, set_buffer := jump_buffer):
		ground = set_ground
		air = set_air
		
		jump_velocity = set_jump
		gravity = set_grav
		
		coyote_time = set_coyote
		jump_buffer = set_buffer

var mani_data := control_data.new(
	move_data.new( ## Ground Movement
		30.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	move_data.new( ## Air Movemnt
		30.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	300.0, # Jump Velocity
	1.0 # Gravity
)
var depr_data := control_data.new(
	move_data.new( ## Ground Movement
		30.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	move_data.new( ## Air Movemnt
		30.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	300.0, # Jump Velocity
	1.0 # Gravity
)
var norm_data := control_data.new(
	move_data.new( ## Ground Movement
		30.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	move_data.new( ## Air Movemnt
		30.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	300.0, # Jump Velocity
	1.0 # Gravity
)

func manic_movement(_delta:float) -> void: pass
func depressive_movement(delta:float) -> void: 
	var data := depr_data
	
	if not is_on_floor(): velocity += get_gravity() * delta * data.gravity
	
	var current_move := data.ground if is_on_floor() else data.air
	
	var direction := Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = move_toward(velocity.x, current_move.max_speed * direction, current_move.acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, current_move.friction * delta)
func normal_movement(delta:float) -> void: 
	var data := norm_data
	
	if not is_on_floor(): velocity += get_gravity() * delta * data.gravity
	
	var current_move := data.ground if is_on_floor() else data.air
	
	var direction := Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = move_toward(velocity.x, current_move.max_speed * direction, current_move.acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, current_move.friction * delta)

func _physics_process(delta: float) -> void:
	
	## Attach the relevant movement.
	match Global.player_state:
		Global.STATES.MANIC:      manic_movement(delta)
		Global.STATES.DEPRESSIVE: depressive_movement(delta)
		Global.STATES.NORMAL:     normal_movement(delta)
	
	move_and_slide()
