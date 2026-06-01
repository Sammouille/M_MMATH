extends AudioStreamPlayer

var last_beat:= 0


@export var start_at:= 0

@export var bpm:= 120.0

signal on_beat(beat: int)

func _ready() -> void:
	play(start_at * (60.0 / bpm))

func _process(delta: float) -> void:
	var stream_pos:= get_playback_position()
	if stream_pos != 0:
		var current_beat:int = stream_pos / (60.0 / bpm)
		if last_beat != current_beat:
			last_beat = current_beat
			on_beat.emit(current_beat)
			print(current_beat)
