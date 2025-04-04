class_name SaveState extends Resource

const SAVE_PATH = "user://save_data.tres"

# Momo Status/Emotion stuff
@export var is_morning:bool = true
@export var daily_status:Array[String] = []
@export var available_status:Array[String] = []
@export var used_status:Array[String] = []

static func load_data() -> Resource:
	if  ResourceLoader.exists(SAVE_PATH):
		print_rich("[color=blue][b]SaveState.load_data():[/b][/color] [color=green]Loading values from savefile ")
		return ResourceLoader.load(SAVE_PATH)
	print_rich("[color=blue][b]SaveState.load_data():[/b][/color] [color=red]Loading default values into Resource")
	return SaveState.new()
	
func save_data() -> void:
	ResourceSaver.save(self,SAVE_PATH)
	print_rich("[color=blue][b]SaveState.save_data():[/b][/color] [color=green]Saving values to savefile ")
