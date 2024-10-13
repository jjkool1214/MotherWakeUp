extends Node

var speakers: Dictionary = {}
var all_dialogue: Dictionary = {}
var dialogueHistory: Array = []

func _ready() -> void:
	speakers = import_speakers()
	all_dialogue = import_all_dialogue()
	reset_ui()

func reset_ui() -> void:
	$Text.text = ""
	$Choice1.disabled = true
	$Choice1.visible = false
	$Choice1.text = ""
	$Choice2.disabled = true
	$Choice2.visible = false
	$Choice2.text = ""

func import_speakers() -> Dictionary:
	var contents: String = FileAccess.get_file_as_string("res://assets/speakers.json")
	return JSON.parse_string(contents)
	
func import_all_dialogue() -> Dictionary:
	var contents: String = FileAccess.get_file_as_string("res://assets/dialogue.json")
	return JSON.parse_string(contents)

func start_dialogue(key: String) -> bool:
	var dialogue: Dictionary = all_dialogue[key]
	for prereq in dialogue["prerequisites"]:
		if prereq not in dialogueHistory:
			return false
	reset_ui()
	$Text.text = dialogue["text"]
	return true
