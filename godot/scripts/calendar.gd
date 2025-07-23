extends Control


var days = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "weekend"]


func load_content():
	for i in days:
		var file = FileAccess.open("user://calendar_" + str(i) + ".dat", FileAccess.READ)
		if file:
			get_node(i).text = file.get_as_text()
			file.close()
		else:
			print("error loading")

func save_content(node):
	var file 
	#if node == main:
		#file = FileAccess.open("user://todo_list_%d_main.dat" % id, FileAccess.WRITE)

	file = FileAccess.open("user://calendar_" + str(node) + ".dat", FileAccess.WRITE)
	file.store_string(get_node(node).text)
	file.close()
	print("saved !")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_content()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lundi_text_changed() -> void:
	save_content("lundi")


func _on_mercredi_text_changed() -> void:
	save_content("mercredi")


func _on_weekend_text_changed() -> void:
	save_content("weekend")


func _on_jeudi_text_changed() -> void:
	save_content("jeudi")


func _on_vendredi_text_changed() -> void:
	save_content("vendredi")


func _on_mardi_text_changed() -> void:
	save_content("mardi")
	
	


func _on_change_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
