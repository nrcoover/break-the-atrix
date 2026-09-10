extends Control


@onready var collected_label: Label = $MC/CollectedLabel
@onready var time_label: Label = $MC/TimeLabel
@onready var exit_label: Label = $MC/ExitLabel
@onready var game_over_rect: ColorRect = $GameOverRect
@onready var game_over_label: Label = $GameOverRect/GameOverLabel


var _pill_count: int = 0
var _collected: int = 0
var _time: float = 0


func _ready() -> void:
	get_tree().paused = false
	subscribe_to_signals()
	get_level_pill_count()
	update_pill_ui()


func _process(delta: float) -> void:
	_time += delta
	update_time_ui(_time)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()


func subscribe_to_signals() -> void:
	SignalManager.pill_collected.connect(on_pill_collected)
	SignalManager.game_over.connect(on_game_over)


func on_pill_collected() -> void:
	_collected += 1
	
	update_pill_ui()
	
	if _collected == _pill_count:
		exit_label.show()
		SignalManager.emit_show_exit()


func on_game_over(has_won: bool) -> void:
	if has_won:
		game_over_label.text = "You won in %.1fs, well done!" % _time
	
	game_over_rect.show()
	
	get_tree().paused = true


func get_level_pill_count() -> void:
	_pill_count = get_tree().get_nodes_in_group("pill").size()


func update_pill_ui() -> void:
	collected_label.text = "%s / %s" % [
		_collected, _pill_count
	]


func update_time_ui(time: float) -> void:
	time_label.text = "%.1fs" % time
