extends Node


signal pill_collected
signal show_exit
signal game_over(has_won: bool)


func emit_pill_collected() -> void:
	pill_collected.emit()


func emit_show_exit() -> void:
	show_exit.emit()


func emit_game_over(has_won: bool) -> void:
	game_over.emit(has_won)
