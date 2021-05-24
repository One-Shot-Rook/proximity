extends Control

var load_client = preload("res://Client.tscn")
var load_item = preload("res://Item.tscn")
var load_course = preload("res://Course.tscn")

var client
var menu

onready var Items = $Main/ScrollContainer_items/Items
onready var Courses = $Main/ScrollContainer_courses/Courses

func _ready():
	pass

func initialize_client():
	client = load_client.instance()
	add_child(client)

func initialize_courses():
	for entry in Menu.get_courses():
		print(entry)
		var course = load_course.instance()
		course.initialize(entry)
		course.connect("course_pressed", self, "initialize_course_items")
		Courses.add_child(course)

func initialize_course_items(course):
	var sub_menu = Menu.get_items_in_course(course)
	for entry in sub_menu:
		var item = load_item.instance()
		item.initialize(sub_menu[entry]["Category"], entry, sub_menu[entry]["Price"])
		Items.add_child(item)
	Courses.get_parent().visible = false
	Items.get_parent().visible = true

func initialize_menu(data):
	var menu_json = JSON.parse(data)
	menu = menu_json.result
	for category in menu.keys():
		for entry in menu[category].keys():
			var item = load_item.instance()
			item.initialize(category, entry, menu[category][entry]["Price"])
			Items.add_child(item)

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


func _on_ButtonMenu_pressed():
	for entry in Items.get_children():
		entry.queue_free()
	Items.get_parent().visible = false
	for entry in Courses.get_children():
		entry.queue_free()
	Courses.get_parent().visible = true
	initialize_courses()


func _on_ButtonConnect_pressed():
	initialize_client()
