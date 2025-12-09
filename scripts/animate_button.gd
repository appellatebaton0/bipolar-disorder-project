class_name AnimateButton extends BaseButton

@export var animation_name := ""

@onready var anim := get_anim()
func get_anim(with:Node = self, depth := 7) -> AnimationPlayer:
	
	if depth == 0: return null
	
	if with is AnimationPlayer: return with
	
	for child in with.get_children():
		if child is AnimationPlayer: return child
	
	return get_anim(with.get_parent(), depth - 1)

func _pressed() -> void:
	anim.play(animation_name)
