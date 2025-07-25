extends Control


var days = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "weekend"]


func load_content():
	for i in days:
		var file = FileAccess.open("user://calendar_" + str(i) + ".dat", FileAccess.READ)
		if file:
			get_node(i + "/" + i).text = file.get_as_text()
			file.close()
		else:
			print("error loading")

func save_content(node):
	var file 
	#if node == main:
		#file = FileAccess.open("user://todo_list_%d_main.dat" % id, FileAccess.WRITE)

	file = FileAccess.open("user://calendar_" + str(node) + ".dat", FileAccess.WRITE)
	file.store_string(get_node(node + "/" + node).text)
	file.close()
	print("saved !")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_content()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_current_date()
		

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


var current_day_color = Color("#cba6f7")
var other_day_color = Color("#6c7086") 
var prev_day
var hours 
var min 
var date
var day : String
var day_number
var month_number
var days_label = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"]

func update_current_date():
	var datetime = Time.get_datetime_dict_from_system()
	hours = datetime.hour
	min = datetime.minute
	day_number = datetime.day
	month_number = datetime.month
	if day_number < 10:
		day_number = "0" + str(day_number) 
	if month_number < 10:
		month_number = "0" + str(month_number)
	
	date = str(day_number) + "/" + str(month_number) + "/" + str(datetime.year)
	day = days_label[datetime.weekday] 
	
	if hours < 10:
		hours = "0" + str(hours)
	if min < 10:
		min = "0" + str(min)
		
		
	$label/day.text = day.to_upper()
	$label/date.text = str(date)
	$label/current_date.text = str(hours) + ":" + str(min)
	
	if prev_day != day:
		
			
		for i in days_label:
			var excepted_color 
			var current_day
			if i == day:
				print(i)
				excepted_color = current_day_color
			else:
				excepted_color = other_day_color
				
			current_day = i
			if i == "dimanche" || i == "samedi":
				current_day = "weekend"
				
			var excpeted_node = str(current_day) + "/" + str(current_day) + "_label" 
			print(excpeted_node)
			print(excepted_color)
			get_node(str(excpeted_node)).label_settings.font_color = excepted_color
			print(get_node(str(excpeted_node)).label_settings.font_color)
	prev_day = day
	
	
	
