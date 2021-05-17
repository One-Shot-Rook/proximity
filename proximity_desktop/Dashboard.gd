extends Control

signal test_order

var load_section = preload("res://Section.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_mainview()
	connect("test_order",get_node("Panel/MainView/Drinks"),"spawn_order")


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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	emit_signal("test_order")
