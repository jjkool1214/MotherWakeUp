extends Node

var speakers: Dictionary = {}
var all_dialogue: Dictionary = {}
var dialogue_history: Array = []

var active_dialogue: Dictionary = {}
var choice_1: Dictionary = {}
var choice_2: Dictionary = {}

func _ready() -> void:
	speakers = import_speakers()
	all_dialogue = import_all_dialogue()
	reset_ui()

func reset_ui() -> void:
	$Avatar.texture = null
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
	var speaker: Dictionary = speakers[dialogue["speaker"]]
	for prereq in dialogue["prerequisites"]:
		if prereq not in dialogue_history:
			return false
	reset_ui()
	$Avatar.texture = load(speaker["avatar"])
	$Text.text = dialogue["text"]
	if len(dialogue["choices"]) == 2:
		choice_1 = dialogue["choices"]["first"]
		choice_2 = dialogue["choices"]["second"]
		$Choice1.disabled = false
		$Choice1.visible = true
		$Choice1.text = choice_1["text"]
		$Choice2.disabled = false
		$Choice2.visible = true
		$Choice2.text = choice_2["text"]
	return true

func _on_choice_1_pressed() -> void:
	if len(choice_1) == 0:
		return
	start_dialogue(choice_1["dialogue"])

func _on_choice_2_pressed() -> void:
	if len(choice_2) == 0:
		return
	start_dialogue(choice_2["dialogue"])
