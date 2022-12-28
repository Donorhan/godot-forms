class_name EmailValidationRule extends ValidationRule

const EMAIL_REGEX = "^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$"

var regex := RegEx.new()

func _init() -> void:
    regex.compile(EMAIL_REGEX)


func check(field_value: Variant, _rule_value: Variant, fail: Callable) -> void:
    var result = regex.search(field_value)
    if not result:
        fail.call("FIELD_INVALID_EMAIL")


func identifier() -> String:
    return "email"
