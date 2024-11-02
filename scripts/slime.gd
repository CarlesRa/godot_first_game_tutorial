extends Node2D

const SPEED = 60
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2.ZERO
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_bottom: RayCast2D = $RayCastBottom
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	apply_gravity(delta)
	handle_x_direction(delta)
	
func handle_x_direction(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
		
	position.x += direction * SPEED * delta
	
func apply_gravity(delta: float) -> void:
	ray_cast_bottom.force_raycast_update()
	
	if not ray_cast_bottom.is_colliding():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		
	position.y += velocity.y * delta
