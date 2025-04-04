extends Node2D

const MOMO_DUMMY = preload("res://MomoDummy.tscn")

@onready var dummy_container: VBoxContainer = %DummyContainer

@onready var save_button: Button = %SaveButton
@onready var load_button: Button = %LoadButton
@onready var new_day_button: Button = %NewDayButton


var momodummies:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=aqua][b]Main._ready()")
	load_button.pressed.connect(_on_load_button_pressed)
	save_button.pressed.connect(_on_save_button_pressed)
	new_day_button.pressed.connect(_on_new_day_button_pressed)
	load_momos_frome_file() 	
	
func _on_load_button_pressed() -> void:
	load_momos_frome_file() 

func load_momos_frome_file() -> void:
	SaveLoader.load_game_data()
	setup_momos_from_file()
	
func  setup_momos_from_file() -> void:

	# set emotions of momos from used emotions
	print_rich("[color=aqua][b]Main.setup_momos_from_file()")
	momodummies = get_momodummies()	
	
	# if it is the first time without savefile then just start a new day
	if GlobalVariables.used_status.is_empty() and not momodummies.is_empty():
		print_rich("[color=red]used_status is empty -> start new day")
		_on_new_day_button_pressed() 
		return
	# make duplicate so we dont manipulate/change the actual array
	var used_status = GlobalVariables.used_status.duplicate()
	for momodummie in momodummies:
		var emotion = used_status.pop_front()
		# if emotion exists (!= null):
		if emotion:
			# this line is only for autocompletion so the editor shows .load_emotion()
			momodummie = momodummie as MomoDummy 
			momodummie.load_emotion(emotion)		
		else:
			break
			
	#only for debug:
	GlobalVariables.print_variables()	

func setup_momos_from_new_emotions() -> void:
	# set from available emotions
	print_rich("[color=aqua][b]Main.setup_momos_from_new_emotions()")
	momodummies = get_momodummies()
	for momodummie in momodummies:
		var emotion = GlobalVariables.get_next_available_emotion()
		# if emotion is empty string, then there is no more emotion.. shouldnt happen though
		if emotion != "":
			momodummie = momodummie as MomoDummy
			momodummie.load_emotion(emotion)		
		else:
			break
			
	#only for debug:
	GlobalVariables.print_variables()
	
func _on_save_button_pressed() -> void:
	SaveLoader.save_game_data()
	get_tree().quit() 
	

func _on_new_day_button_pressed() -> void:
	print_rich("[color=aqua][b]New Day!")
	GlobalVariables.randomize_daily_emotions()
	setup_momos_from_new_emotions()

		
func get_momodummies() -> Array:
	return get_tree().get_nodes_in_group("MomoDummy")
	
