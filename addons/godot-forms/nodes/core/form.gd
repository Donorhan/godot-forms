class_name Form extends PanelContainer
@icon("../../icons/form.svg")

signal form_submitted(data: Dictionary)

const VALUE_REGEX = "\\[(.*?)\\]"

@export var field_rules : Dictionary

var data_validator = DataValidator.new()
var form_fields : Dictionary
var regex = RegEx.new()
var value_regex = RegEx.new()


func _ready() -> void:
    value_regex.compile(VALUE_REGEX)

    data_validator.set_fields_rules(field_rules)
    data_validator.connect("on_error_state_changed", _on_validator_error)

    find_and_attach_form_fields()


func submit() -> void:
    var values = _get_form_fields_values()
    data_validator.execute(values)

    if data_validator.validated():
        form_submitted.emit(values)


func _get_form_fields_values() -> Dictionary:
    var inputs_values = {}
    for input_key in form_fields.keys():
        inputs_values[input_key] = form_fields[input_key].get_value()

    return inputs_values


func _on_form_field_validation_asked(form_field: FormField) -> void:
    data_validator.execute_for_key(form_field.identifier, form_field.get_value())


func _on_validator_error(error: String, form_field_identifier: String, rule_infos: Dictionary) -> void:
    var form_field = form_fields.get(form_field_identifier)
    if form_field:
        var formatted_error := tr(error)
        var rule_value = rule_infos.get("value", "")
        formatted_error = value_regex.sub(formatted_error, str(rule_value), true)
        form_field.set_error(formatted_error)


func find_and_attach_form_fields() -> void:
    # save references to form fields and listen to the validation asked signal
    var fields := get_all_form_fields(self)
    for form_field in fields:
        form_field.connect("validation_asked", _on_form_field_validation_asked)
        form_fields[form_field.identifier] = form_field


static func get_all_form_fields(node: Node) -> Array[FormField]:
    var children : Array[FormField] = []
    for child in node.get_children():
        if child is FormField:
            children.append(child)

        children += get_all_form_fields(child)

    return children
