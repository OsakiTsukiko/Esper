extends Node
class_name MapGen

const directional_arr: Array = [Vector2(0, -1), Vector2(1, 0), Vector2(-1,0), Vector2(0, 1)]

class DungeonRoom:
	var id: int = -1
	var coord: Vector2
	
	func _init(id: int, coords: Vector2):
		self.id = id
		self.coord = coords

static func count_adjacent_rooms(width: int, height: int, matrix: Array, coords: Vector2):
	var count = 0
	for k in directional_arr:
		var neighbor_coord = Vector2(coords.x + k.x, coords.y + k.y)
		if (neighbor_coord.x >= 0 && neighbor_coord.x < width &&
			neighbor_coord.y >= 0 && neighbor_coord.y < height &&
			matrix[neighbor_coord.x][neighbor_coord.y].id != -1):
			count += 1
	return count

static func generate_map_matrix(width: int, height: int, room_count: int, min_full_path: int) -> Array:
	var max_val = -1
	var max_val_coord
	var cell_queue: Array = []
	var directional_arr = [Vector2(0, -1), Vector2(1, 0), Vector2(-1,0), Vector2(0, 1)]
	var matrix: Array = []
	var room_array: Array = []
	
	
	while max_val < min_full_path:
		max_val = -1
		max_val_coord = Vector2.ZERO
		matrix.resize(width)
		for i in range(matrix.size()):
			matrix[i] = []
			matrix[i].resize(height)
			for j in range(matrix[i].size()):
				var room = DungeonRoom.new(-1, Vector2(i,j))
				matrix[i][j] = room


		matrix[floor(width/2)][floor(height/2)].id = 0
		room_array.append(matrix[floor(width/2)][floor(height/2)])
		randomize()
		
		#CREATE RANDOM ROOM LAYOUT
		var index = 1
		while index < room_count:
			var room_rand = room_array[randi() % room_array.size()]
			var room_check
			var avv_sides: Array = []
			
			
			if (room_rand.coord.x >= 0 && room_rand.coord.x < width &&
				room_rand.coord.y - 1 >= 0 && room_rand.coord.y - 1 < height):
				room_check = matrix[room_rand.coord.x][room_rand.coord.y - 1]
				if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
					avv_sides.append(1)
			
			
			if (room_rand.coord.x + 1 >= 0 && room_rand.coord.x + 1 < width &&
				room_rand.coord.y >= 0 && room_rand.coord.y < height):
				room_check = matrix[room_rand.coord.x + 1][room_rand.coord.y]
				if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
					avv_sides.append(2)
			
			
			if (room_rand.coord.x - 1 >= 0 && room_rand.coord.x - 1 < width &&
				room_rand.coord.y >= 0 && room_rand.coord.y < height):
				room_check = matrix[room_rand.coord.x - 1][room_rand.coord.y]
				if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
					avv_sides.append(3)
			
			
			if (room_rand.coord.x >= 0 && room_rand.coord.x < width &&
				room_rand.coord.y + 1 >= 0 && room_rand.coord.y + 1 < height):
				room_check = matrix[room_rand.coord.x][room_rand.coord.y + 1]
				if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
					avv_sides.append(4)
						
			if avv_sides.size() != 0:
				var rand_side = randi() % avv_sides.size()
				if avv_sides[rand_side] == 1:
					matrix[room_rand.coord.x][room_rand.coord.y - 1].id = 1
					room_array.append(matrix[room_rand.coord.x][room_rand.coord.y - 1])
				if avv_sides[rand_side] == 2:
					matrix[room_rand.coord.x + 1][room_rand.coord.y].id = 1
					room_array.append(matrix[room_rand.coord.x + 1][room_rand.coord.y])
				if avv_sides[rand_side] == 3:
					matrix[room_rand.coord.x - 1][room_rand.coord.y].id = 1
					room_array.append(matrix[room_rand.coord.x - 1][room_rand.coord.y])
				if avv_sides[rand_side] == 4:
					matrix[room_rand.coord.x][room_rand.coord.y + 1].id = 1
					room_array.append(matrix[room_rand.coord.x][room_rand.coord.y + 1])
				index += 1

		# CREATE DIRECTIONAL MATRIX
		var distance_matrix: Array = []
		distance_matrix.resize(width)
		for i in range(width):
			distance_matrix[i] = []
			distance_matrix[i].resize(height)
			for j in range(height):
				if matrix[i][j].id == -1:
					distance_matrix[i][j] = -1
				else:
					distance_matrix[i][j] = 0
		# LEE FOR DISTANCES IN DIRECTIONAL MATRIX
		distance_matrix[floor(width/2)][floor(height/2)] = 1
		cell_queue.push_back(Vector2(floor(width/2), floor(height/2)))
		while !cell_queue.empty():
			var cell_coord = cell_queue.front()
			var is_cell_last = 1
			cell_queue.pop_front()
			for i in directional_arr:
				var neighbor_cell_coord = cell_coord + i
				if (neighbor_cell_coord.x >= 0 && neighbor_cell_coord.x < width &&
					neighbor_cell_coord.y >= 0 && neighbor_cell_coord.y < height):
					if (distance_matrix[neighbor_cell_coord.x][neighbor_cell_coord.y] != -1 && 
					distance_matrix[neighbor_cell_coord.x][neighbor_cell_coord.y] == 0):
						is_cell_last = 0
						cell_queue.push_back(Vector2(neighbor_cell_coord.x, neighbor_cell_coord.y))
						distance_matrix[neighbor_cell_coord.x][neighbor_cell_coord.y] = distance_matrix[cell_coord.x][cell_coord.y] + 1
						if distance_matrix[neighbor_cell_coord.x][neighbor_cell_coord.y] > max_val:
							max_val = distance_matrix[neighbor_cell_coord.x][neighbor_cell_coord.y]
							max_val_coord = Vector2(neighbor_cell_coord.x, neighbor_cell_coord.y)

			if is_cell_last:
				matrix[cell_coord.x][cell_coord.y].id = 2
		
		matrix[max_val_coord.x][max_val_coord.y].id = 3
	return matrix
