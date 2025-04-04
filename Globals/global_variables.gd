extends Node


var use_dict:bool = false

var max_nr_emotions:int = 3
var is_morning:bool = true

var status:Array[String] = ["hurt", "neglected", "sick", "bored", "eepy", "unkept", "sad", "stinky"]
var daily_status:Array[String] = []
var available_status:Array[String] = []
var used_status:Array[String] = []

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	
	# only for debugging
	print_rich("[color=magenta][b]GlobalVariables._ready()[/b][/color] ")
	print_variables()
	# 
	
	randomize_daily_emotions()
	
	
func randomize_daily_emotions() -> void:
	var randomized_status = status.duplicate()
	randomized_status.shuffle()
	daily_status = randomized_status.slice(0,max_nr_emotions)	# get the first three(max_nr_emotions) emotions of the shuffled array
	available_status = daily_status.duplicate()
	used_status.clear()
	# only for debugging
	print_rich("[color=magenta]GlobalVariables.randomize_emotions()[/color] ")
	print_variables()

func get_next_available_emotion() -> String:	
	# get the next emotion in the array
	# if there is no more element (emotion = null): return empty string
	var emotion = available_status.pop_front()			
	if emotion: 
		used_status.append(emotion)
		return emotion
	else:
		return ""

func add_available_emotion(emotion:String) -> void:
	if available_status.size() >= 3:
		return		
	available_status.append(emotion)
	used_status.erase(emotion)
	
# only for debugging
func print_variables() -> void:
	printt("is_morning: ", is_morning)
	printt("status: ", status)
	printt("daily_status: ", daily_status)
	printt("available_status: ", available_status)
	printt("used_status: ", used_status)
