extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 0.1) var mouse_sensitivity := 0.25

@export_group("Movement")
@export var move_speed := 6.0
@export var acceleration := 3.0

var _camera_input_direction := Vector2.ZERO

@export var joystick_right : VirtualJoystick

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("left_click"):
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#print("Detectando mouse")
	#if event.is_action_pressed("ui_cancel"):
		#print("No detectando mouse")
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and 
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity 

func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x,
	-PI / 6.0, PI / 3.0)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	_camera_input_direction = Vector2.ZERO
	
	var raw_input := Input.get_vector("move_left", "move_right", 
	"move_up", "move_down", 0.4)
	var forward:= _camera.global_basis.z
	var right:= _camera.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	move_and_slide()
