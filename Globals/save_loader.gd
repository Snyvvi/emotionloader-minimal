extends Node

# still works with your FileAccess stuff

func load_game_data() -> void:
	var savestate:SaveState = SaveState.load_data()
	
	GlobalVariables.is_morning = savestate.is_morning 
	GlobalVariables.daily_status = savestate.daily_status
	GlobalVariables.available_status = savestate.available_status
	GlobalVariables.used_status = savestate.used_status
	# only for debugging
	GlobalVariables.print_variables()
	

func save_game_data() -> void:
	var savestate:SaveState = SaveState.new()
	savestate.is_morning = GlobalVariables.is_morning
	savestate.daily_status = GlobalVariables.daily_status
	savestate.available_status =  GlobalVariables.available_status 
	savestate.used_status = GlobalVariables.used_status
	# only for debugging
	GlobalVariables.print_variables()
	
	savestate.save_data()
