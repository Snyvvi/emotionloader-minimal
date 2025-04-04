class_name MomoDummy extends HBoxContainer
@onready var emotion_label: Label = $EmotionLabel

var emotion:String:set = _set_emotion


func _ready() -> void:
	_set_emotion(emotion)

func load_emotion(_emotion:String) -> void:
	emotion = _emotion
	print_rich("[color=aqua]MomoDummy.load_emotion(): [/color]", emotion)
	

func _set_emotion(value) -> void:
	emotion = value
	if is_node_ready():
		emotion_label.text = emotion
