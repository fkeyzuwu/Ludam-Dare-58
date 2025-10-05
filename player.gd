class_name Player extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 3.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_range(0.1, 5.0, 0.01) var mouse_sensitivity := 1.0

@onready var camera: Camera3D = $Camera3D
@export var interaction_raycast: RayCast3D
@export var hud: HUD
@export var inventory: PlayerInventory
@onready var spawn_pos := global_position
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hud.dialogue_box.opened.connect(_on_dialogue_box_opened)
	hud.dialogue_box.closed.connect(_on_dialogue_box_closed)

enum State {
	Idle,
	Dialogue,
	Crafting
}

var state := State.Idle

func _exit_current_state() -> void:
	match state:
		State.Crafting:
			hud.crafter.return_crafting_slots()
			hud.crafter.hide_crafter()

func enter_state(_state: State) -> void:
	_exit_current_state()
	
	match _state:
		State.Idle:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		State.Dialogue:
			hud.hide_interaction_text()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		State.Crafting:
			hud.hide_interaction_text()
			hud.crafter.show_crafter()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	state = _state

func _on_dialogue_box_opened() -> void:
	enter_state(State.Dialogue)
	
func _on_dialogue_box_closed() -> void:
	enter_state(State.Idle)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and state == State.Idle:
		var delta = get_process_delta_time()
		global_rotation.y -= event.relative.x * delta * mouse_sensitivity
		camera.global_rotation.x -= event.relative.y * delta * mouse_sensitivity
		camera.global_rotation_degrees.x = clampf(camera.global_rotation_degrees.x, -85, 85)
	elif event.is_action_pressed(&"craft"):
		if state == State.Idle:
			enter_state(State.Crafting)
		elif state == State.Crafting:
			enter_state(State.Idle)
	elif event.is_action_pressed(&"change_mouse_mode"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	move(delta)
	try_interact()

func move(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and state == State.Idle:
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and state == State.Idle:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func try_interact() -> void:
	match state:
		State.Idle:
			if interaction_raycast.is_colliding():
				var interactable = interaction_raycast.get_collider()
				if not interactable:
					hud.hide_interaction_text()
				else:
					if interactable.can_interact():
						if Input.is_action_just_pressed(&"interact"):
							await interactable.interact(self)
						else:
							hud.show_interaction_text(interactable.get_interaction_text())
					else:
						hud.hide_interaction_text()
			else:
				hud.hide_interaction_text()
		State.Dialogue:
			if Input.is_action_just_pressed(&"interact") or Input.is_action_just_pressed(&"mouse_left"):
				hud.dialogue_box.continue_dialogue()

func kill() -> void:
	global_position = spawn_pos
	animation_player.play(&"respawn")
	move_and_slide()
