extends Control

"""
Save & Load
"""

@export var id = 0
@onready var tasks: TextEdit = $tasks
@onready var main: TextEdit = $main

#const save_path
func save_content(node : TextEdit):
	var file 
	if node == main:
		file = FileAccess.open("user://todo_list_%d_main.dat" % id, FileAccess.WRITE)
	elif node == tasks:
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
	file = FileAccess.open("user://todo_list_%d_main.dat" % id, FileAccess.READ)
	if file:
		main.text = file.get_as_text()
		file.close()
	else:
		print("error loading")
		
func _on_tasks_text_changed() -> void:
	save_content(tasks)

func _on_main_text_changed() -> void:
	save_content(main)

"""
Global
"""

func _ready() -> void:
	load_content()
