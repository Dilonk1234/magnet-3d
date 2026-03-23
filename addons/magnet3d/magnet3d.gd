@icon("uid://oph6p7xo0tv")
extends Area3D
class_name Magnet3D

@export var target : Node3D
@export var strength := 20.0
@export var damping_strength := 5.0

func _physics_process(delta: float) -> void:
	if not target:
		push_error(get_path(), " Needs a target. Magnet will do nothing.")
		return
	
	for x: Node3D in get_overlapping_bodies():
		if not x is RigidBody3D:
			continue
		
		var direction := target.global_position - x.global_position
		var distance := direction.length()
		var damping : Vector3 = -x.linear_velocity * damping_strength
		if distance > 0:
			var force := direction * strength
			x.apply_force(force + damping)
