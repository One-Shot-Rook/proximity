extends Node

var menu_data

func _ready():
	var menu_data_file = File.new()
	menu_data_file.open("res://Menu/menu.json", File.READ)
	var menu_data_json = JSON.parse(menu_data_file.get_as_text())
	menu_data_file.close()
	menu_data = menu_data_json.result

func get_menu():
	return menu_data
