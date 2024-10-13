extends Node

signal trigger_player_teleport

var game_state: State = State.TITLE
var enter_door_target_position: Vector2 = Vector2.ZERO

enum State { TITLE, STAGE_0, STAGE_1, STAGE_2, STAGE_3 }
enum Scene { TITLE_MENU, EXTERIORS, HOME_INTERIOR, CAVE_INTERIOR }

const all_scenes = {
	"exteriors": preload("res://scenes/Exteriors.tscn"),
	"home-interior": preload("res://scenes/HomeInterior.tscn"),
	"cave-interior": preload("res://scenes/Cave.tscn"),
	"mother-room": preload("res://scenes/MotherRoom.tscn")
}

func change_scene(key: String, target_position: Vector2):
	if not key in all_scenes:
		return
	
	var scene: PackedScene = all_scenes[key]
	Transition.start_fade()
	await Transition.on_transition_finished
	get_tree().change_scene_to_packed(scene)
	enter_door_target_position = target_position
