extends Node2D


@export var speed: float = 80.0


@onready var label: Label = $Label
@onready var nav_agent_2d: NavigationAgent2D = $NavAgent2D


var _last_delta: float = 0.0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		nav_agent_2d.target_position = get_global_mouse_position()


func _physics_process(delta: float) -> void:	
	
	_last_delta = delta
	update_label()
	
	if nav_agent_2d.is_navigation_finished(): return
	
	var next_path_position: Vector2 = nav_agent_2d.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * speed
	#position += direction * speed * delta
	#rotation = direction.angle()
	nav_agent_2d.velocity = new_velocity


func update_label() -> void:
	var debug_text: String = "TP: %.0v\n" % nav_agent_2d.target_position
	debug_text += "Reachable: %s\n" % nav_agent_2d.is_target_reachable()
	debug_text += "Reached: %s\n" % nav_agent_2d.is_target_reached()
	debug_text += "Finished: %s" % nav_agent_2d.is_navigation_finished()
	label.text = debug_text


func _on_nav_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	global_position += safe_velocity * _last_delta
	#rotation = safe_velocity.angle()
	
	if safe_velocity.length() > 0.01:
		# this will smooth our object's rotation during velocity recalculations
		rotation = rotate_toward(rotation, safe_velocity.angle(), deg_to_rad(360) * _last_delta)
