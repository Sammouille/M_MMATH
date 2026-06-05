extends MarginContainer

@onready var nom:= %Nom
@onready var score:= %Score

func fin():
	await get_tree().create_timer(0.6).timeout
	await get_tree().create_tween().tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0,).finished
	queue_free()
