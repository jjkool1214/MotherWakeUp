extends Node

var game_state: State = State.TITLE

enum State { TITLE, STAGE_0, STAGE_1, STAGE_2, STAGE_3 }
enum Scene { TITLE_MENU, EXTERIORS, HOME_INTERIOR, CAVE_INTERIOR }

const all_scenes = {
	"exteriors": preload("res://scenes/Exteriors.tscn"),
	"home_interior": preload("res://scenes/HomeInterior.tscn"),
	"cave_interior": preload("res://scenes/Cave.tscn"),
	"mother-room": preload("res://scenes/MotherRoom.tscn")
}

func change_scene(key):
	if not key in all_scenes:
		return
	
	var scene: PackedScene = all_scenes[key]
	Transition.start_fade()
	await Transition.on_transition_finished
	get_tree().change_scene_to_packed(scene)
