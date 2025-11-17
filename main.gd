extends Node2D

@onready var subViewportContainer : SubViewportContainer = $SubViewportContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.viewport_container = subViewportContainer
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
