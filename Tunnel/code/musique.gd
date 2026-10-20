extends AudioStreamPlayer

var last_beat:= 0

var anti_reste:= 0

var replay:= 0

@onready var total_beats:= (stream.get_length() / 60.0) * bpm

@export var start_at:= 0

@export var bpm:= 120.0

signal on_beat(beat: int)

var last_stream_pos:= 0.0

func _ready() -> void:
	play(start_at * (60.0 / bpm))

func _process(delta: float) -> void:
	var stream_pos:= get_playback_position()
	if last_stream_pos > stream_pos:
		replay += 1
		anti_reste = last_beat
	if stream_pos != 0:
		var current_beat:int = stream_pos / (60.0 / bpm) + anti_reste
		if replay > 0:
			current_beat -= 58
		if last_beat != current_beat:
			last_beat = current_beat
			on_beat.emit(current_beat)
			print(current_beat)
	last_stream_pos = stream_pos
