class_name Wall extends Reactor

@onready var anim := $AnimationPlayer

func _on_switch(to:bool):
	current_value = to

var updated:bool
func _active(_delta:float) -> void:
	if updated != current_value and not anim.is_playing():
		anim.play("on" if current_value else "off")
		updated = current_value
		
