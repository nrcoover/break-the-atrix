extends Node2D


@export var speed: float = 25.0
@export var range_px: float = 100.0


@onready var nav_obstacle: NavigationObstacle2D = $NavObstacle


var min_y: float
var max_y: float
var dir: int = 1


var _velocity: Vector2


func _ready() -> void:
	min_y = global_position.y - range_px
	max_y = global_position.y + range_px
	dir = -1 if randf() < 0.5 else 1


func _physics_process(delta: float) -> void:
	if global_position.y > max_y:
		dir = -1
	elif global_position.y < min_y:
		dir = 1
		_velocity = speed * Vector2(0, dir)
		nav_obstacle.velocity = _velocity
	global_position += _velocity * delta
