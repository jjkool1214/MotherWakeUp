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
	reset()
	
func _process(delta: float) -> void:
	if len(active_dialogue) == 0:
		return
	
	if not Input.is_action_just_pressed("dialogue"):
		return
		
	if not choice_1.is_empty() and not choice_2.is_empty():
		return
	
	if active_dialogue["next"].is_empty():
		reset()
		Game.freeze_player = false
		return
	
	start_dialogue(active_dialogue["next"])

func reset() -> void:
	active_dialogue = {}
	choice_1 = {}
	choice_2 = {}
	$AvatarFrame.visible = false
	$Avatar.texture = null
	$TextFrame.visible = false
	$ButtonHint.visible = false
	$Text.visible_ratio = 0;
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
	
	reset()
	Game.freeze_player = true
	active_dialogue = dialogue
	dialogue_history.append(key)
	
	$AvatarFrame.visible = true
	$Avatar.texture = load(speaker["avatar"])
	
	var path = "res://assets/SFX/voices/" + speaker["name"] + ".mp3"
	$"../../Voices".stream = load(path)
	$"../../Voices".play()
	
	$TextFrame.visible = true
	$ButtonHint.visible = true
	set_text(dialogue["text"])
	
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

func set_text(text: String) -> void:
	$Text.text = text
	var tween: Tween = create_tween()
	tween.tween_property($Text, "visible_ratio", 1.0, 2)

func _on_choice_1_pressed() -> void:
	if choice_1.is_empty():
		return
	print(choice_1["dialogue"])
	start_dialogue(choice_1["dialogue"])

func _on_choice_2_pressed() -> void:
	if choice_2.is_empty():
		return
	start_dialogue(choice_2["dialogue"])
