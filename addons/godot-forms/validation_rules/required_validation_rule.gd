class_name RequiredValidationRule extends ValidationRule

func check(field_value: Variant, _rule_value: Variant, fail: Callable) -> void:
    if field_value is bool and field_value != true:
        fail.call("FIELD_REQUIRED")
    elif field_value is String and field_value.length() == 0:
        fail.call("FIELD_REQUIRED")


func identifier() -> String:
    return "required"
