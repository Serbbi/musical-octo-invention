extends GridMap

func interact(player) -> void:
	var ray = player.interact_ray
	var collider = ray.get_collider()
	
	if collider is GridMap:
		var collision_point = ray.get_collision_point()
		
		var normal = ray.get_collision_normal()
		var adjusted_point = collision_point + normal * 0.1
		var cell = collider.local_to_map(adjusted_point)
		
		collider.set_cell_item(cell, 0)
