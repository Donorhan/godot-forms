class_name UILineEdit extends UIFormField
@icon("../../icons/form-field.svg")

@export var check_on_text_changed := true

var _focused := false
var _hovered := false

func update_container_style() -> void:
    if not _field_container:
        return

    if _hovered:
        var focus_stylebox = _field_container.get_theme_stylebox("hover", "FieldContainer")
        _field_container.add_theme_stylebox_override("panel", focus_stylebox)

    if _focused:
        var focus_stylebox = _field_container.get_theme_stylebox("focus", "FieldContainer")
        _field_container.add_theme_stylebox_override("panel", focus_stylebox)

    if not _hovered and not _focused:
        _field_container.remove_theme_stylebox_override("panel")


func _on_line_edit_focus_entered() -> void:
    _focused = true
    update_container_style()


func _on_line_edit_focus_exited() -> void:
    _focused = false
    update_container_style()
    validation_asked.emit(self)


func _on_line_edit_mouse_entered() -> void:
    _hovered = true
    update_container_style()


func _on_line_edit_mouse_exited() -> void:
    _hovered = false
    update_container_style()


func _on_line_edit_text_changed(new_text: String) -> void:
    if check_on_text_changed:
        validation_asked.emit(self)
