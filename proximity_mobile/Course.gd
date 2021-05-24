extends Control

var title:String

signal course_pressed(course_name)

func _ready():
	pass # Replace with function body.

func initialize(input_title):
	title = input_title
	$Label.text = title

func _on_Button_pressed():
	emit_signal("course_pressed",title)
