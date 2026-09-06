class_name Player

extends CharacterBody2D


@export var speed: float = 120


func _physics_process(delta: float) -> void:
	handle_input()


func handle_input() -> void:
	var input: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input.normalized() * speed
	rotation = velocity.angle()
	move_and_slide()
