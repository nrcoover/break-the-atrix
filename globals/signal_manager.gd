extends Node


signal pill_collected
signal show_exit


func emit_pill_collected() -> void:
	pill_collected.emit()


func emit_show_exit() -> void:
	show_exit.emit()
