extends Label

@export var state_machine : Node

func _physics_process(_delta: float) -> void:
	self.text = state_machine.current_state.name
