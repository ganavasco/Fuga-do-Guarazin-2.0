extends MarginContainer

@export var score_label: Label
@export var configs_tab: Control


func _process(_delta: float) -> void:
	@warning_ignore("narrowing_conversion")
	var displayed_score: int = MainSingleton.stage.weighted_progress * GameMode.features.progress_to_score_ratio
	score_label.text = str("%0*d" % [GameMode.features.score_zeroes_padding, displayed_score])


func _on_button_pressed() -> void:
	configs_tab.visible = true
	get_tree().paused = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and not configs_tab.visible:
		configs_tab.visible = true
		get_tree().paused = true
