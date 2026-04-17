extends Node3D

signal change_tile()

func player_interact() -> void:
	change_tile.emit(self)
