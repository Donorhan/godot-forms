class_name ValidationRule extends Object

func identifier() -> String:
    assert(false, "Validation rule identifier not specified")
    return ""


func check(_field_value: Variant, _rule_value: Variant, _fail: Callable) -> void:
    pass
