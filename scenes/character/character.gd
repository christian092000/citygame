extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 0.5) var camera_sensitivity: float = 3

@export_group("Movement")
@export var move_speed: float = 6.0
@export var acceleration: float = 1.0

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D

# Variable para mostrar el mensaje en pantalla
var show_message = false
var message_timer = 2.0  # Duración del mensaje en segundos

@onready var label = $Label

func _ready() -> void:
	$CollisionShape3D.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	# Verifica si el nodo pertenece al grupo "limites"
	if body.is_in_group("limites"):
		show_message = true
		if label:
			label.visible = true
		await get_tree().create_timer(message_timer).timeout
		show_message = false
		if label:
			label.visible = false
# Este joystick controla la cámara
@export var joystick_camera: VirtualJoystick

func _physics_process(delta: float) -> void:
	# *** Movimiento de la cámara con joystick ***
	# Capturamos la entrada de las acciones asociadas al joystick de la cámara
	var camera_horizontal: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var camera_vertical: float = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Aplicar rotaciones
	_camera_pivot.rotation.y -= camera_horizontal * camera_sensitivity * delta # Rotación horizontal (Yaw)
	_camera_pivot.rotation.x += camera_vertical * camera_sensitivity * delta  # Rotación vertical (Pitch)

	# Limitar inclinación vertical
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)

	# *** Movimiento del personaje (respetado) ***
	var raw_input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.4)
	var forward: Vector3 = _camera.global_basis.z
	var right: Vector3 = _camera.global_basis.x
	var move_direction: Vector3 = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()

	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	move_and_slide()
