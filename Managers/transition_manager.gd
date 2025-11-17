extends Node

@onready var fade : ColorRect = $CanvasLayer/FadeColor
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.hide()
	
func fade_in() -> void:
	fade.show()
	animation_player.play("scene_transition_fade")

	await(animation_player.animation_finished)
	fade.hide()
	
func fade_out() -> void:
	fade.show()
	animation_player.play_backwards("scene_transition_fade")

	await(animation_player.animation_finished)
	fade.hide()
