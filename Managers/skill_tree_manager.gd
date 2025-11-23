extends Node
class_name SkillTreeManager

#------------------
# SkillTreeManager
#------------------
# Manages getting the input and then opening a specified skill tree scene.
# There can be several skill trees with differing inputs
# No two skill trees can share the same inputs.

# Signals

signal return_to_game


# Camera Settings and Variables
@export var SkillTreeLayerPath : NodePath
@export var SkillTreeCameraPath : NodePath
@onready var SkillTreeLayer : CanvasLayer = get_node(SkillTreeLayerPath) as CanvasLayer
@onready var SkillTreeCamera : Camera2D = get_node(SkillTreeCameraPath) as Camera2D
var DefaultZoom : float = 1.0


# SkillTree
var SkillTreeScenePacked : PackedScene = preload("res://SkillTrees/skill_tree.tscn")
var ActiveSkillTree : SkillTree = null
@export var OccupationSkillTreeData : SkillTreeData
@export var CombatSkillTreeData : SkillTreeData

# Default Action Binding Names
var OpenOccupationBinding : String = "OpenOccupationSkillTree" # O
var OpenCombatClassBinding : String = "OpenCombatClassSkillTree" # P

var hasSkillTreeOpen : bool = false

# Input:SkillTree
var SkillTreeCatalog : Dictionary = {}
var MissingActions : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check if the SkillTrees will actually be accessible. Warn if they are not.
	if not InputMap.has_action(OpenOccupationBinding):
		push_warning("Missing InputMap action : " + OpenOccupationBinding)
		MissingActions = true
	if not InputMap.has_action(OpenCombatClassBinding):
		push_warning("Missing InputMap action : " + OpenCombatClassBinding)
		MissingActions = true

	# Build SkillTreeCatalog
	if not MissingActions:
		SkillTreeCatalog[OpenOccupationBinding] = OccupationSkillTreeData
		SkillTreeCatalog[OpenCombatClassBinding] = CombatSkillTreeData

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check each binding and open the appropriate tree
	
	if not MissingActions:
		for action in SkillTreeCatalog:
			if Input.is_action_just_pressed(action) && !hasSkillTreeOpen:
				hasSkillTreeOpen = !hasSkillTreeOpen
				# print("[SkillTreeManager] Unpacking skill tree")
				open_skill_tree()
				# load_skill_tree(SkillTreeCatalog[action])
			elif Input.is_action_just_pressed(action) && hasSkillTreeOpen:
				hasSkillTreeOpen = !hasSkillTreeOpen
				
				if ActiveSkillTree != null:
					ActiveSkillTree.queue_free()
				# print("[SkillTreeManager] Closing skill tree")
				close_skill_tree()

func load_skill_tree(skillTreeData : SkillTreeData) -> void:
	ActiveSkillTree = SkillTreeScenePacked.instantiate()
	ActiveSkillTree.load_skill_tree_data(skillTreeData)
	SkillTreeLayer.add_child(ActiveSkillTree)

func open_skill_tree() -> void:
	# Reset Camera Position
	SkillTreeCamera.position = Vector2.ZERO
	SkillTreeCamera.zoom = Vector2.ONE
	
	# Give Skill Tree Camera Control
	SkillTreeCamera.make_current()
	SkillTreeCamera.set_process_input(true)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close_skill_tree() -> void:
	# Restore original Camara controls and settings
	SkillTreeCamera.set_process_input(false)
	emit_signal("return_to_game")
