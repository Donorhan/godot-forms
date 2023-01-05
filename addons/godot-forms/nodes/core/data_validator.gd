class_name DataValidator extends Object

signal on_error_state_changed(error: String, key: String, rule_info: Dictionary)

var _default_validation_rules := {
    "email": EmailValidationRule.new(),
    "max": MaxValidationRule.new(),
    "min": MinValidationRule.new(),
    "number": NumberValidationRule.new(),
    "required": RequiredValidationRule.new(),
}

var _errors := {}
var _rules := {}
var _validation_rules = {}


func _init() -> void:
    _validation_rules = _default_validation_rules.duplicate()


func _notification(what: int) -> void:
    if what == NOTIFICATION_PREDELETE:
        for rule in _validation_rules.values():
            rule.free()


func add_rule(rule_key: String, rule_validation: ValidationRule) -> void:
    _validation_rules[rule_key] = rule_validation


func execute(data: Dictionary) -> void:
    for key in data.keys():
        execute_for_key(key, data[key])


func execute_for_key(key: String, value: Variant) -> void:
    if not _rules.has(key):
        return

    validate(key, value, _rules[key])


func validate(key: String, value: Variant, rules: String) -> void:
    set_error(key, "")
    var rules_list = rules.split("|", false)

    for rule in rules_list:
        if _errors.has(key):
            return

        var rule_splitted := rule.split(":")
        var rule_identifier = rule_splitted[0] as String
        var rule_value = rule_splitted[1] if rule_splitted.size() > 1 else 0

        var validation_rule = _validation_rules.get(rule_identifier)
        assert(validation_rule, "The validation rule " + rule_identifier + " is missing")

        validation_rule.check(value, rule_value, func(error: String): set_error(key, error, { "identifier": rule_identifier, "value": rule_value }))


func validated() -> bool:
    return _errors.keys().size() == 0


func set_fields_rules(rules: Dictionary) -> void:
    _rules = rules


func set_error(key: String, error: String, rule_infos: Dictionary = {}) -> void:
    on_error_state_changed.emit(error, key, rule_infos)

    if error.length() == 0:
        _errors.erase(key)
    else:
        _errors[key] = error
