class_name Intrusion extends TileMapLayer

var switch:bool

func _ready() -> void:
	PlayerState.became_depressed.connect(_on_depress)
	PlayerState.became_not_depressed.connect(_on_undepress)
	
	switch = PlayerState.player_state == PlayerState.STATES.DEPRESSIVE
	modulate.a = 0
func _process(delta: float) -> void:
	if !switch: modulate.a = move_toward(modulate.a, 0.0, delta * 3)
	else:       modulate.a = move_toward(modulate.a, 1.0, delta * 3)
	enabled = modulate.a > 0

func _on_depress() -> void: 
	switch = true
func _on_undepress() -> void: 
	switch = false
