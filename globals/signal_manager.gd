extends Node


signal on_pill_collected
signal on_show_exit


func emit_on_pill_collected() -> void:
	on_pill_collected.emit()


func emit_on_show_exit() -> void:
	on_show_exit.emit()
