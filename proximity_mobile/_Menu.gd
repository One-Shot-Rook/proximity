extends Node

var menu = {}
var courses = {
	"Drinks":{}
}

func _ready():
	pass # Replace with function body.

func initialize_menu(data):
	var menu_json = JSON.parse(data)
	menu = menu_json.result
	for category in menu.keys():
		for entry in menu[category].keys():
			if category == "Drinks":
				courses["Drinks"][entry] = menu[category][entry]
				courses["Drinks"][entry]["Category"] = "Drinks"
			elif category == "Food":
				if courses.has(menu[category][entry]["Course"]):
					courses[menu[category][entry]["Course"]][entry] = menu[category][entry]
					courses[menu[category][entry]["Course"]][entry]["Category"] = "Food"
				else:
					courses[menu[category][entry]["Course"]] = {}
					courses[menu[category][entry]["Course"]][entry] = menu[category][entry]
					courses[menu[category][entry]["Course"]][entry]["Category"] = "Food"

func get_items_in_course(input_course):
	return courses[input_course]

func get_courses():
	return courses.keys()
