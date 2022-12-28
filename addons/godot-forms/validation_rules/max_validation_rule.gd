class_name MaxValidationRule extends ValidationRule

func check(field_value: Variant, rule_value: Variant, fail: Callable) -> void:
    var max_value = rule_value.to_int()
    if field_value.length() > max_value:
        fail.call("FIELD_INVALID_MAX")


func identifier() -> String:
    return "max"
