extends Control

signal test_order
signal drinks_order(content)
signal food_order(content)
signal misc_order(content)

var load_server = preload("res://Server.tscn")
var load_section = preload("res://Section.tscn")


var server
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_mainview()
	initialize_server()
	connect("test_order",get_node("Panel/MainView/Drinks"),"spawn_order")
	connect("drinks_order",get_node("Panel/MainView/Drinks"),"order_received")
	connect("food_order",get_node("Panel/MainView/Food"),"order_received")
	connect("misc_order",get_node("Panel/MainView/Misc"),"order_received")


func initialize_mainview():
	var section = load_section.instance()
	section.set_title("Drinks")
	$Panel/MainView.add_child(section)
	section = load_section.instance()
	section.set_title("Food")
	$Panel/MainView.add_child(section)
	section = load_section.instance()
	section.set_title("Misc")
	$Panel/MainView.add_child(section)

func initialize_server():
	server = load_server.instance()
	add_child(server)
	server.rect_position = Vector2(0,700)

func incoming_order(type, content):
	match type:
		"d":
			emit_signal("drinks_order",content)
		"f":
			emit_signal("food_order",content)
		"m":
			emit_signal("misc_order",content)

func _on_Button_pressed():
	emit_signal("test_order")


func _on_showServer_pressed():
	if server.visible == true:
		server.visible = false
	else:
		server.visible = true


func _on_clearLogs_pressed():
	server.get_node("Label").text = ""
