class_name UIFormField extends FormField
@icon("../../icons/form-field.svg")

@export var label : String = ""

@onready var _error_text = %ErrorLabel as Label
@onready var _field_container = %FieldContainer as PanelContainer
@onready var _field_label = %FieldLabel as Label

func _ready() -> void:
    super._ready()

    if label.length() > 0:
        _field_label.text = label


func set_error(error: String) -> void:
    super.set_error(error)
    _error_text.text = error

