class_name Player extends CharacterBody2D

func _init() -> void: Global.player = self

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

var jump_buffer := 0.0
var coyote_time := 0.0

var direction:float

var mani_data := control_data.new(
	move_data.new( ## Ground Movement
		135.0, # Max Speed
		135.0, # Acceleration
		135.0 # Friction
	),
	move_data.new( ## Air Movemnt
		125.0, # Max Speed
		125.0, # Acceleration
		125.0 # Friction
	),
	300.0, # Jump Velocity
	0.8) # Gravity
var depr_data := control_data.new(
	move_data.new( ## Ground Movement
		60.0, # Max Speed
		500.0, # Acceleration
		400.0 # Friction
	),
	move_data.new( ## Air Movemnt
		50.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	260.0, # Jump Velocity
	1.0) # Gravity
var norm_data := control_data.new(
	move_data.new( ## Ground Movement
		100.0, # Max Speed
		400.0, # Acceleration
		500.0 # Friction
	),
	move_data.new( ## Air Movemnt
		90.0, # Max Speed
		300.0, # Acceleration
		300.0 # Friction
	),
	275.0, # Jump Velocity
	0.9) # Gravity

func gravity(amnt:float, delta:float) -> void: if not is_on_floor(): velocity += get_gravity() * delta * amnt
func jumping(data:control_data, delta:float) -> void:
	
	coyote_time = move_toward(coyote_time, 0, delta)
	jump_buffer = move_toward(jump_buffer, 0, delta)
	
	if is_on_floor(): coyote_time = data.coyote_time
	if Input.is_action_just_pressed("Jump"): jump_buffer = data.jump_buffer
	
	if coyote_time and jump_buffer:
		
		velocity.y -= data.jump_velocity
		
		coyote_time = 0
		jump_buffer = 0

var wall_coyote := 0.0
var wall_normal:float
func wall_jumping(data:control_data, move:move_data, delta:float): 
	
	wall_coyote = move_toward(wall_coyote, 0, delta)
	if is_on_wall_only(): 
		wall_coyote = 0.1
		wall_normal = get_wall_normal().x
	
	if wall_coyote and jump_buffer: # WALL JUMPING
		velocity.y -= data.jump_velocity * 1
		velocity.x = move.max_speed * wall_normal * 1.5
		
		wall_coyote = 0.0
		jump_buffer = 0.0
	
	pass

func movement(max_speed:float, acceleration:float, friction:float, delta:float):
	direction = Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = move_toward(velocity.x, max_speed * direction, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func manic_movement(delta:float) -> void: 
	var data := mani_data
	
	gravity(data.gravity, delta)
	jumping(data, delta)
	
	var move := data.ground if is_on_floor() else data.air
	wall_jumping(data, move, delta)
	
	if not is_on_floor():
		var try = Input.get_axis("Left", "Right")
		if try != 0: direction = try
	
	if is_on_wall(): direction = -direction
	
	if direction == 0: direction = 1
	
	velocity.x = move_toward(velocity.x, move.max_speed * direction, move.acceleration * delta)
func depressive_movement(delta:float) -> void: 
	var data := depr_data
	
	gravity(data.gravity, delta)
	jumping(data, delta)
	
	var move := data.ground if is_on_floor() else data.air
	
	movement(move.max_speed, move.acceleration, move.friction, delta)
func normal_movement(delta:float) -> void: 
	var data := norm_data
	
	gravity(data.gravity, delta)
	jumping(data, delta)
	
	var move := data.ground if is_on_floor() else data.air
	
	movement(move.max_speed, move.acceleration, move.friction, delta)

func _physics_process(delta: float) -> void:
	
	## Attach the relevant movement.
	match PlayerState.player_state:
		PlayerState.STATES.MANIC:      manic_movement(delta)
		PlayerState.STATES.DEPRESSIVE: depressive_movement(delta)
		PlayerState.STATES.NORMAL:     normal_movement(delta)
	
	
	
	move_and_slide()
