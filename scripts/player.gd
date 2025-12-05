class_name Player extends CharacterBody2D

func manic_movement(_delta:float) -> void: pass
func depressive_movement(_delta:float) -> void: pass
func normal_movement(_delta:float) -> void: pass

func _physics_process(delta: float) -> void:
	
	match Global.player_state:
		Global.STATES.MANIC:
			pass
		Global.STATES.DEPRESSIVE:
			pass
		Global.STATES.NORMAL:
			pass
	
	move_and_slide()
