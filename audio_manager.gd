extends Node

@onready var garbage_sound_player: AudioStreamPlayer = $GarbageSoundPlayer
@onready var crafted_item_sound_player: AudioStreamPlayer = $CraftedItemSoundPlayer
@onready var dialogue_continue_sound_player: AudioStreamPlayer = $DialogueContinueSoundPlayer
@onready var dialogue_open_sound_player: AudioStreamPlayer = $DialogueOpenSoundPlayer
@onready var dialogue_closed_sound_player: AudioStreamPlayer = $DialogueClosedSoundPlayer
@onready var footstep_player: AudioStreamPlayer = $FootstepPlayer

func play_garbage_pickup_sound() -> void:
	garbage_sound_player.play()

func play_crafted_item_sound() -> void:
	crafted_item_sound_player.play()
