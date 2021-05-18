tool
extends Control

var item_name = "" setget set_item_name
var item_amount = 0 setget set_item_amount
var item_price = 0.0 setget set_item_price

onready var Name = $HBox/Name
onready var Price = $HBox/Price
onready var Amount = $HBox/Center/Amount
onready var BtnPlus = $HBox/Center/Plus/Button
onready var BtnMinus = $HBox/Center/Minus/Button

func _ready():
	self.item_name = item_name
	self.item_price = item_price
	self.item_amount = item_amount

func _get_property_list() -> Array:
	return [
		{
			name = "Item",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "item_name",
			type = TYPE_STRING,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "item_price",
			type = TYPE_REAL,
			hint = PROPERTY_HINT_RANGE,
			hint_string = "0,100.00",
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
	]

func set_item_name(new_item_name):
	item_name = new_item_name
	if Name:
		Name.text = item_name

func set_item_amount(new_item_amount):
	if new_item_amount < 0:
		return
	item_amount = new_item_amount
	if Amount and BtnMinus:
		Amount.text = str(item_amount)
		BtnMinus.disabled = (item_amount == 0)
		BtnMinus.modulate = Color.white * int(item_amount != 0)

func set_item_price(new_item_price):
	item_price = new_item_price
	if Price:
		Price.text = float_to_currency(item_price)


func _on_item_amount_appended(change):
	self.item_amount += change


func float_to_currency(flt) -> String:
	var sections = str(stepify(flt,0.01)).split(".")
	var cur = ""
	if sections.size() == 1:
		cur = sections[0] + ".00"
	else:
		cur = sections[0] + "." + sections[1]
		for _zero in 2 - sections[1].length():
			cur += "0"
	return "£" + cur






