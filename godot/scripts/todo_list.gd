extends Control

var global_font_size : int = 20
var current_font_size : int = global_font_size
"""
Save & Load
"""

@export var id = 0
@onready var tasks: TextEdit = $tasks

#const save_path
func save_content(node : TextEdit):
	var file 
	#if node == main:
		#file = FileAccess.open("user://todo_list_%d_main.dat" % id, FileAccess.WRITE)
	if node == tasks:
		file = FileAccess.open("user://todo_list_%d_tasks.dat" % id, FileAccess.WRITE)
	file.store_string(node.text)
	file.close()
	print("saved !")
	
func load_content():
	var file = FileAccess.open("user://todo_list_%d_tasks.dat" % id, FileAccess.READ)
	if file:
		tasks.text = file.get_as_text()
		file.close()
	else:
		print("error loading")
	#file = FileAccess.open("user://todo_list_%d_main.dat" % id, FileAccess.READ)
	#if file:
		#main.text = file.get_as_text()
		#file.close()
	#else:
		#print("error loading")
		
func _on_tasks_text_changed() -> void:
	save_content(tasks)

#func _on_main_text_changed() -> void:
	#save_content(main)

"""
Global
"""

func _ready() -> void:
	load_content()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("decrease_font"):
		current_font_size -= 1
		$tasks.add_theme_font_size_override("font_size", current_font_size)
	if Input.is_action_just_pressed("increase_font"):
		current_font_size += 1
		$tasks.add_theme_font_size_override("font_size", current_font_size)
	if Input.is_action_just_pressed("reset_font_size"):
		$tasks.add_theme_font_size_override("font_size", global_font_size)
