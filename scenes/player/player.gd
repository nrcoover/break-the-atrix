class_name Player

extends CharacterBody2D


@export var speed: float = Constants.player_speed


func _physics_process(_delta: float) -> void:
	handle_input()


func handle_input() -> void:
	var input: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input.normalized() * speed
	
	if !is_zero_approx(velocity.length()):
		rotation = velocity.angle()
	
	move_and_slide()
