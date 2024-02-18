class_name FormField extends PanelContainer

signal error_state_changed(error: String)
signal validation_asked(form_field: FormField)

@export var identifier : String = ""
@export_node_path("Control") var input_path : NodePath

var _input : Control

func _ready() -> void:
	_input = get_node_or_null(input_path)


func ask_validation() -> void:
	validation_asked.emit(self)


func set_error(error: String) -> void:
	error_state_changed.emit(error)


func get_value() -> Variant:
	if _input is LineEdit:
		return _input.text
	elif _input is CheckBox:
		return _input.button_pressed

	return null
