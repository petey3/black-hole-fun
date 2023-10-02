# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

export (Dictionary) var state_properties

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
export var initial_state := NodePath()

export (bool) var enter_initial_state_on_ready = false

# The current active state. At the start of the game, we get the `initial_state`.
onready var state: State = get_node(initial_state)

func _ready() -> void:
	yield(owner, "ready")
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self

	if enter_initial_state_on_ready:
		enter_initial_state()


func enter_initial_state():
	transition_to(state.name)


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta) 
	# TODO: Maybe also alway pass in state properties
	# or subclass state to take a special data object
	# so transitions can be made on things like 
	# velocity, scale, "abstract input" or whatever


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `properties` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, properties: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return

	state = get_node(target_state_name)
	
	for key in state_properties:
		if not properties.has(key):
			var value = state_properties[key]
			
			if value is NodePath:
				value = get_node(value)
			
			properties[key] = value
	
	state.state_machine = self
	state.enter(properties)
	emit_signal("transitioned", state.name)

	
