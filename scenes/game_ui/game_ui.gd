extends Control


@onready var collected_label: Label = $MC/CollectedLabel
@onready var time_label: Label = $MC/TimeLabel
@onready var exit_label: Label = $MC/ExitLabel


var _pill_count: int = 0
var _collected: int = 0
var _time: float = 0


func _ready() -> void:
	subscribe_to_signals()
	update_pill_ui()


func _process(delta: float) -> void:
	_time += delta
	update_time_ui(_time)


func subscribe_to_signals() -> void:
	SignalManager.on_pill_collected.connect(on_pill_collected)
	_pill_count = get_tree().get_nodes_in_group("pill").size()


func on_pill_collected() -> void:
	_collected += 1
	
	update_pill_ui()
	
	if _collected == _pill_count:
		exit_label.show()
		SignalManager.emit_on_show_exit()


func update_pill_ui() -> void:
	collected_label.text = "%s / %s" % [
		_collected, _pill_count
	]


func update_time_ui(time: float) -> void:
	time_label.text = "%.1fs" % time
