class_name Level extends Node

func _init() -> void: Global.level = self

@export var antidepressants := 0
@export var depressants := 0

@onready var anti_label := $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/AntiLabel
@onready var depr_label := $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/DepressLabel

@onready var anti_text := $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/Antidepressant
@onready var depr_text := $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/Depressants

@onready var reset_bar := $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/TextureProgressBar

@onready var vbar := $"CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/-"

@export var reset_time := 2.0
var reset_timer := 0.0

func _ready() -> void:
	reset_bar.max_value = reset_time * 100
	
	if antidepressants <= 0:
		anti_label.hide()
		anti_text.hide()
		vbar.hide()
	if depressants <= 0:
		depr_label.hide()
		depr_text.hide()
		vbar.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Mania") and antidepressants > 0: 
		PlayerState.state_to(PlayerState.STATES.MANIC)
		antidepressants -= 1
	if Input.is_action_just_pressed("Depress") and depressants > 0: 
		PlayerState.state_to(PlayerState.STATES.DEPRESSIVE)
		depressants -= 1
	
	anti_label.text = str(antidepressants)
	depr_label.text = str(depressants)
	
	anti_text.modulate = Color(1,1,1,1) if antidepressants else Color(0.5,0.5,0.5,1)
	depr_text.modulate = Color(1,1,1,1) if depressants     else Color(0.5,0.5,0.5,1)
	
	reset_timer = move_toward(reset_timer, reset_time if Input.is_action_pressed("Reset") else 0.0, delta)
	if reset_timer >= reset_time:
		reset_timer = 0.0
		
		# Reset the level.
		LevelManager.reset()
	
	reset_bar.value = reset_timer * 100
	
