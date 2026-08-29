extends Node2D


@export var speed: float = 80.0


@onready var label: Label = $Label


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		pass


func _physics_process(delta: float) -> void:	
	update_label()


func update_label() -> void:
	label.text = ""


