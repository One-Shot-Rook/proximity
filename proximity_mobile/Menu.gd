extends Control

var load_client = preload("res://Client.tscn")

var client

onready var Items = $Main/ScrollContainer/Items

func _ready():
	initialize_client()
	pass

func initialize_client():
	client = load_client.instance()
	add_child(client)

func _on_ButtonCheckout_pressed():
	var order = compile_order()
	print(order)
	client.send_order(order)

func compile_order():
	var order = {
		"FOOD":{},
		"DRINK":{},
		"MISC":{}
	}
	for item in Items.get_children():
		if item.get_item_amount() == 0:
			continue
		match item.get_item_category():
			0:
				order["FOOD"][item.get_item_name()] = {"Amount": item.get_item_amount()}
			1:
				order["DRINK"][item.get_item_name()] = {"Amount": item.get_item_amount()}
			2:
				order["MISC"][item.get_item_name()] = {"Amount": item.get_item_amount()}
	return order
