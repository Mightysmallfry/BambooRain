extends Node
class_name SkillTreeManager

#------------------
# SkillTreeManager
#------------------
# Manages getting the input and then opening a specified skill tree scene.
# There can be several skill trees with differing inputs
# No two skill trees can share the same inputs.

# UILayer is the layer that the Skill Tree Ui be created on top of
@export var UILayer : CanvasLayer

var SkillTreeScenePacked : PackedScene = preload("res://SkillTrees/skill_tree.tscn")

# SkillTree
@export var OccupationSkillTreeData : SkillTreeData
@export var CombatSkillTreeData : SkillTreeData

# Default Action Binding Names
var OpenOccupationBinding : String = "OpenOccupationSkillTree" # O
var OpenCombatClassBinding : String = "OpenCombatClassSkillTree" # P

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
			if Input.is_action_just_pressed(action):
				print("[{get_class()}] unpacking skill tree")
				open_skill_tree(SkillTreeCatalog[action])

func open_skill_tree(skillTreeData : SkillTreeData) -> void:
	var SkillTreeSceneNode : Node = SkillTreeScenePacked.instantiate()
	SkillTreeSceneNode.load_skill_tree_data(skillTreeData)
	UILayer.add_child(SkillTreeSceneNode)
