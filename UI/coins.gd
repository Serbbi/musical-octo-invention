extends PanelContainer

@onready var amount_label: Label = $HBoxContainer/Label

func set_coins_amount(number: int) -> void:
	amount_label.text = "%s" % number
