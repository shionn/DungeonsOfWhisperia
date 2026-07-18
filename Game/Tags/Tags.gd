class_name Tags
extends Node

const AUBERGE_PLAYER_RESTORED = "AUBERGE_PLAYER_RESTORED"
const AUBERGE_PLAYER_KNOW_SHADOW_CHASM = "AUBERGE_PLAYER_KNOW_SHADOW_CHASM"
const AUBERGE_PLAYER_KNOW_VALTHORION = "AUBERGE_PLAYER_KNOW_VALTHORION"
const AUBERGE_ALLIANCE_RETURNED = "AUBERGE_ALLIANCE_RETURNED"
const DUNGEON_01_ENABLE = "DUNGEON_01_ENABLE"
const DUNGEON_01_FINISHED = "DUNGEON_01_FINISHED"
const DUNGEON_02_ENABLE = "DUNGEON_02_ENABLE"
const DUNGEON_02_VISIT_CULT_ROOM = "DUNGEON_02_VISIT_CULT_ROOM"

var _tags : Array[String] = []

signal tag_change()

func add(tag : String) -> void : 
	_tags.append(tag)
	tag_change.emit()

func remove(tag : String) -> void : 
	var index = _tags.find(tag)
	if index >= 0 :
		_tags.remove_at(index)
	tag_change.emit()

func have(tag : String) -> bool:
	return _tags.find(tag) >= 0
