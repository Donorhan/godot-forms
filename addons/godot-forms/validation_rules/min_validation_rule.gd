class_name MinValidationRule extends ValidationRule

func check(field_value: Variant, rule_value: Variant, fail: Callable) -> void:
    var min_value = rule_value.to_int()
    if field_value.length() < min_value:
        fail.call("FIELD_INVALID_MIN")


func identifier() -> String:
    return "min"
