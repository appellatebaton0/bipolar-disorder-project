class_name Intrusion extends TileMapLayer

func _ready() -> void:
	PlayerState.became_depressed.connect(_on_depress)
	PlayerState.became_not_depressed.connect(_on_undepress)
	
	enabled = PlayerState.player_state == PlayerState.STATES.DEPRESSIVE


func _on_depress() -> void: 
	enabled = true
func _on_undepress() -> void: 
	enabled = false
