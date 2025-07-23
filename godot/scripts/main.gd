extends Control

"""
Nodes importation
"""

@onready var toggle_pomo : Button = $buttons/toggle_pomo
@onready var pause_pomo : Button = $buttons/pause_pomo
@onready var prev_page : Button = $buttons/prev
@onready var next_page : Button = $buttons/next
@onready var next_page_label: Label = $labels/next_label
@onready var pomo_state_label: Label = $labels/pomo_state
@onready var pomo_value_label: Label = $labels/pomo_value
@onready var current_date_label: Label = $labels/current_date
@onready var prev_page_label: Label = $labels/prev_label
@onready var pomo_counter: Timer = $pomo_counter
@onready var change_pomo: Button = $buttons/change_pomo


"""
Pomodoro
"""

enum pomo_state {
	WORK,
	BREAK,
	STOPPED,
	NOTLAUNCHED,
	PAUSED
}
var current_pomo_state : pomo_state = pomo_state.NOTLAUNCHED

var pomo_pause_toggle : bool = true # true : pomo will be paused || false : continue
var pomo_toggle : bool = true # true : pomo will start | false : pomo will stop
var work_time : int = 50 # 50mn work
var break_time : int = 10 # 10mn break
var time_remaining : float
var format_adjustement_min : String = ""
var format_adjustement_sec : String = ""
var prev_pomo_state : pomo_state


func _on_change_pomo_pressed() -> void:
	if work_time == 50:
		work_time = 25
	else:
		work_time = 50
		
	if break_time == 10:
		break_time = 5
	else:
		break_time = 10

	display_pomo()

func start_pomo(): # func that start pomo timer and manage work and break session
	if current_pomo_state == pomo_state.WORK:
		current_pomo_state = pomo_state.BREAK
		pomo_counter.wait_time = break_time * 60 # convert min -> sec
		pomo_counter.start() # start timer
	elif current_pomo_state == pomo_state.BREAK or current_pomo_state == pomo_state.NOTLAUNCHED or current_pomo_state == pomo_state.STOPPED:
		current_pomo_state = pomo_state.WORK
		pomo_counter.wait_time = work_time * 60 # convert min -> sec
		pomo_counter.start() # start timer
		
	
func stop_pomo(): # func that stop the pomo
	pomo_counter.stop()
	current_pomo_state = pomo_state.STOPPED

func display_pomo(): # func that display pomo on the label
	# first update pomo state display
	match current_pomo_state:
		pomo_state.WORK:
			pomo_state_label.text = "WORKING"
		pomo_state.BREAK:
			pomo_state_label.text = "BREAK"
		pomo_state.NOTLAUNCHED:
			pomo_state_label.text = "NOT LAUNCHED"
		pomo_state.STOPPED:
			pomo_state_label.text = "STOPPED"
		pomo_state.PAUSED:
			pomo_state_label.text = "PAUSED"
	# then pomo timer
	if current_pomo_state == pomo_state.NOTLAUNCHED or current_pomo_state == pomo_state.STOPPED:
		pomo_value_label.text = str(work_time) + ":00"
	else:
		if (int(pomo_counter.time_left) / 60) < 10:
			format_adjustement_min = "0"
		else:
			format_adjustement_min = ""
			
		if (int(pomo_counter.time_left) % 60) < 10:
			format_adjustement_sec = "0"
		else:
			format_adjustement_sec = ""
			
		pomo_value_label.text = format_adjustement_min + str(int(pomo_counter.time_left) / 60) + ":" + format_adjustement_sec + str(int(pomo_counter.time_left) % 60) # format and print time left

func _on_toggle_pomo_pressed() -> void: # called when btn is pressed
	if pomo_toggle == true:
		start_pomo()
	else:
		stop_pomo()
	
	pomo_toggle = !pomo_toggle

func _on_pause_pomo_pressed() -> void: # called when btn is pressed
	if pomo_pause_toggle:
		pomo_counter.paused = true
		prev_pomo_state = current_pomo_state
		current_pomo_state = pomo_state.PAUSED
	else:
		pomo_counter.paused = false
		current_pomo_state = prev_pomo_state
	
	pomo_pause_toggle = !pomo_pause_toggle

func _on_pomo_counter_timeout() -> void: # called when timer finished
	start_pomo()
	
"""
Current date
"""
var datetime = Time.get_datetime_dict_from_system()
var hours 
var min 

func update_current_date():
	hours = datetime.hour
	min = datetime.minute
	
	if hours < 10:
		hours = "0" + str(hours)
	if min < 10:
		min = "0" + str(min)
		
	current_date_label.text = str(hours) + ":" + str(min)


"""
Save & Load
"""
@onready var todo_list_1: Control = $"todo_container/todo-list"
@onready var todo_list_2: Control = $"todo_container/todo-list2"
@onready var todo_list_3: Control = $"todo_container/todo-list3"
@onready var todo_list_4: Control = $"todo_container/todo-list4"
@onready var todo_list_5: Control = $"todo_container/todo-list5"
@onready var todo_list_6: Control = $"todo_container/todo-list6"
@onready var current_page: Label = $labels/current_page

enum todo_list {
	TODO1,
	TODO2,
	TODO3,
	TODO4,
	TODO5,
	TODO6
}
var current_todo_list : todo_list = todo_list.TODO1

func display_todo_list():
	match current_todo_list:
		todo_list.TODO1:
			todo_list_1.show()
			todo_list_2.hide()
			todo_list_3.hide()
			todo_list_4.hide()
			todo_list_5.hide()
			todo_list_6.hide()
		todo_list.TODO2:
			todo_list_1.hide()
			todo_list_2.show()
			todo_list_3.hide()
			todo_list_4.hide()
			todo_list_5.hide()
			todo_list_6.hide()
		todo_list.TODO3:
			todo_list_1.hide()
			todo_list_2.hide()
			todo_list_3.show()
			todo_list_4.hide()
			todo_list_5.hide()
			todo_list_6.hide()
		todo_list.TODO4:
			todo_list_1.hide()
			todo_list_2.hide()
			todo_list_3.hide()
			todo_list_4.show()
			todo_list_5.hide()
			todo_list_6.hide()
		todo_list.TODO5:
			todo_list_1.hide()
			todo_list_2.hide()
			todo_list_3.hide()
			todo_list_4.hide()
			todo_list_5.show()
			todo_list_6.hide()
		todo_list.TODO6:
			todo_list_1.hide()
			todo_list_2.hide()
			todo_list_3.hide()
			todo_list_4.hide()
			todo_list_5.hide()
			todo_list_6.show()
			
	current_page.text =  str(current_todo_list + 1)

func _on_prev_pressed() -> void:
	if current_todo_list > 0:
		current_todo_list -= 1
	display_todo_list()

func _on_next_pressed() -> void:
	if current_todo_list < 5:
		current_todo_list += 1
	display_todo_list()


"""
Global
"""

func _ready() -> void:
	#load_todo()
	pass

func _process(delta: float) -> void:
	display_pomo()
	update_current_date()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/calendar.tscn")
