class_name Bullet


extends Area2D


var _velocity: Vector2 = Vector2.ZERO


func setup(direction: Vector2) -> void:
	_velocity = direction * Constants.bullet_speed
	rotation = direction.angle()


func _physics_process(delta: float) -> void:
	position += _velocity * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SignalManager.emit_game_over(false)
	
	queue_free()
