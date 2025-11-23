extends Node2D

@onready var subViewportContainer : SubViewportContainer = $SubViewportContainer
@onready var GameObserver : Camera2D = $GameObserver

@onready var SkillTreeManager : Node = $SkillTreeManager


# TODO:
# Stop the subvieport game from receiving input
# when the active camera is not the game observer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.viewport_container = subViewportContainer
	GameObserver.make_current()

	SkillTreeManager.return_to_game.connect(Callable(self, "_on_return_to_game"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_to_game():
	GameObserver.make_current()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
