extends Node
class_name LevelController
# Control / manage da level and whats going on in there

# States
# Set up board
# Introduction
# Turn Sequence
# -- Player Turn
# -- Chaos Turn
# -- (Repeats)
# End Level
# Exit Level 

onready var state_machine = $StateMachine

var shots_taken
