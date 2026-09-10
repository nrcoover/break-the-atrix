extends Area2D


func _ready() -> void:
	hide()
	subscribe_to_signals()


func subscribe_to_signals() -> void:
	SignalManager.show_exit.connect(on_show_exit)


func on_show_exit() -> void:
	set_monitoring.call_deferred(true)
	show()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player exited!")
