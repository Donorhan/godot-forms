class_name NumberValidationRule extends ValidationRule

const NUMBER_TYPES := [TYPE_INT, TYPE_FLOAT]

func check(field_value: Variant, _rule_value: Variant, fail: Callable) -> void:
    var type = typeof(field_value)
    if not NUMBER_TYPES.has(type):
        fail.call("FIELD_INVALID_NUMBER")


func identifier() -> String:
    return "number"
