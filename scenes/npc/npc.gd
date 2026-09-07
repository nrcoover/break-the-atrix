extends Area2D


enum EnemyState { Patrolling, Searching, Chasing }


@export var speed: float = Constants.npc_speed
@export var patrol_points: Node2D


@onready var nav_agent: NavigationAgent2D = $NavAgent
@onready var player_detect: RayCast2D = $PlayerDetect
@onready var debug_label: Label = $CanvasLayer/DebugLabel
@onready var gasp: AudioStreamPlayer2D = $Gasp


var _patrol_points: Array[Vector2]
var _state: EnemyState = EnemyState.Patrolling
var _patrol_index: int = 0
var _player_ref: Player


func _ready() -> void:
	for node in patrol_points.get_children():
		if node is Marker2D: _patrol_points.append(node.global_position)
	
	if _patrol_points.size() < 2:
		queue_free()
		return
	
	identify_player()


func _physics_process(delta: float) -> void:
	handle_player_detection()
	process_behaviour()
	update_movement(delta)
	update_raycast()
	
	update_debug_label()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position()


func update_movement(delta: float) -> void:
	if nav_agent.is_navigation_finished(): return
	
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_path_position)
	position += direction * speed * delta
	rotation = direction.angle()


func identify_player() -> void:
	_player_ref = get_tree().get_first_node_in_group("player")
	
	if !_player_ref:
		queue_free()
		return


func can_see_player() -> bool:
	var max_angle_of_sight: int = 60
	return player_detect.get_collider() is Player and abs(get_field_of_view_angle()) < max_angle_of_sight


func get_field_of_view_angle() -> float:
	var direction: Vector2 = global_position.direction_to(_player_ref.global_position)
	var angle_to_player: float = transform.x.angle_to(direction)
	return rad_to_deg(angle_to_player)


func handle_player_detection() -> void:
	if can_see_player():
		change_state(EnemyState.Chasing)
	elif _state == EnemyState.Chasing:
		change_state(EnemyState.Searching)


func update_raycast() -> void:
	player_detect.look_at(_player_ref.global_position)


func navigate_to_patrol_point() -> void:
	nav_agent.target_position = _patrol_points[_patrol_index]
	var incrementor: int = 1
	_patrol_index = (_patrol_index + incrementor) % _patrol_points.size()


func process_patrolling() -> void:
	if nav_agent.is_navigation_finished():
		navigate_to_patrol_point()


func process_searching() -> void:
	if nav_agent.is_navigation_finished():
		change_state(EnemyState.Patrolling)


func process_chasing() -> void:
	nav_agent.target_position = _player_ref.global_position


func process_behaviour() -> void:
	match _state:
		EnemyState.Patrolling:
			process_patrolling()
		EnemyState.Chasing:
			process_chasing()
		EnemyState.Searching:
			process_searching()


func change_state(new_state: EnemyState) -> void:
	if new_state == _state: return
	
	_state = new_state
	
	match _state:
		EnemyState.Chasing:
			if not gasp.is_playing():
				gasp.play()


func update_debug_label() -> void:
	debug_label.text = "See Player: %s" % can_see_player()
	debug_label.text += "\nFOV: %.1f" % get_field_of_view_angle()
	debug_label.text += "\nState: %s" % EnemyState.keys()[_state]
