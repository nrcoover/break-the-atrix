extends Area2D


@onready var collection_sound: AudioStreamPlayer2D = $CollectionSound
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $Collision


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collection_sound.play()
		disable_pill()
		SignalManager.emit_pill_collected()


func disable_pill() -> void:
	hide()


func _on_collection_sound_finished() -> void:
	queue_free()
