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
	var length_matrix: Array = []
	
	matrix.resize(width)
	length_matrix.resize(width)
	
	for i in range(matrix.size()):
		matrix[i] = []
		matrix[i].resize(height)
		length_matrix[i] = []
		length_matrix[i].resize(height)
		for j in range(matrix[i].size()):
			var room = DungeonRoom.new(-1, Vector2(i,j))
			matrix[i][j] = room
			length_matrix[i][j] = -1
	
	length_matrix[floor(width/2)][floor(height/2)] = 0
	matrix[floor(width/2)][floor(height/2)].id = 0
	room_array.append(matrix[floor(width/2)][floor(height/2)])
	randomize()
	
	var index = 1
	
	while index <= min_full_path:
		var room_prev = room_array[room_array.size() - 1]
		var room_check
		var avv_sides: Array = []
		
		if (room_prev.coord.x >= 0 && room_prev.coord.x < width &&
			room_prev.coord.y - 1 >= 0 && room_prev.coord.y - 1 < height):
			room_check = matrix[room_prev.coord.x][room_prev.coord.y - 1]
			if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
				avv_sides.append(1)
		
		if (room_prev.coord.x + 1 >= 0 && room_prev.coord.x + 1 < width &&
			room_prev.coord.y >= 0 && room_prev.coord.y < height):
			room_check = matrix[room_prev.coord.x + 1][room_prev.coord.y]
			if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
				avv_sides.append(2)
		
		if (room_prev.coord.x - 1 >= 0 && room_prev.coord.x - 1 < width &&
			room_prev.coord.y >= 0 && room_prev.coord.y < height):
			room_check = matrix[room_prev.coord.x - 1][room_prev.coord.y]
			if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
				avv_sides.append(3)
		
		if (room_prev.coord.x >= 0 && room_prev.coord.x < width &&
			room_prev.coord.y + 1 >= 0 && room_prev.coord.y + 1 < height):
			room_check = matrix[room_prev.coord.x][room_prev.coord.y + 1]
			if count_adjacent_rooms(width, height, matrix, room_check.coord) == 1 && room_check.id == -1:
				avv_sides.append(4)


		if avv_sides.size() != 0:
			var rand_side = randi() % avv_sides.size()
			if avv_sides[rand_side] == 1:
				matrix[room_prev.coord.x][room_prev.coord.y - 1].id = 1
				length_matrix[room_prev.coord.x][room_prev.coord.y - 1] = length_matrix[room_prev.coord.x][room_prev.coord.y] + 1
				room_array.append(matrix[room_prev.coord.x][room_prev.coord.y - 1])
			if avv_sides[rand_side] == 2:
				matrix[room_prev.coord.x + 1][room_prev.coord.y].id = 1
				length_matrix[room_prev.coord.x + 1][room_prev.coord.y] = length_matrix[room_prev.coord.x][room_prev.coord.y] + 1
				room_array.append(matrix[room_prev.coord.x + 1][room_prev.coord.y])
			if avv_sides[rand_side] == 3:
				matrix[room_prev.coord.x - 1][room_prev.coord.y].id = 1
				length_matrix[room_prev.coord.x - 1][room_prev.coord.y] = length_matrix[room_prev.coord.x][room_prev.coord.y] + 1
				room_array.append(matrix[room_prev.coord.x - 1][room_prev.coord.y])
			if avv_sides[rand_side] == 4:
				matrix[room_prev.coord.x][room_prev.coord.y + 1].id = 1
				length_matrix[room_prev.coord.x][room_prev.coord.y + 1] = length_matrix[room_prev.coord.x][room_prev.coord.y] + 1
				room_array.append(matrix[room_prev.coord.x][room_prev.coord.y + 1])
			index += 1
	
	room_array[room_array.size() - 1].id = 3
	
	while index <= room_count:
		var room_rand = room_array[randi() % room_array.size()]
		var room_check
		var avv_sides: Array = []
		
		if length_matrix[room_rand.coord.x][room_rand.coord.y] + 1 <= min_full_path:
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
					length_matrix[room_rand.coord.x][room_rand.coord.y - 1] = length_matrix[room_rand.coord.x][room_rand.coord.y] + 1
					room_array.append(matrix[room_rand.coord.x][room_rand.coord.y - 1])
				if avv_sides[rand_side] == 2:
					matrix[room_rand.coord.x + 1][room_rand.coord.y].id = 1
					length_matrix[room_rand.coord.x + 1][room_rand.coord.y] = length_matrix[room_rand.coord.x][room_rand.coord.y] + 1
					room_array.append(matrix[room_rand.coord.x + 1][room_rand.coord.y])
				if avv_sides[rand_side] == 3:
					matrix[room_rand.coord.x - 1][room_rand.coord.y].id = 1
					length_matrix[room_rand.coord.x - 1][room_rand.coord.y] = length_matrix[room_rand.coord.x][room_rand.coord.y] + 1
					room_array.append(matrix[room_rand.coord.x - 1][room_rand.coord.y])
				if avv_sides[rand_side] == 4:
					matrix[room_rand.coord.x][room_rand.coord.y + 1].id = 1
					length_matrix[room_rand.coord.x][room_rand.coord.y + 1] = length_matrix[room_rand.coord.x][room_rand.coord.y] + 1
					room_array.append(matrix[room_rand.coord.x][room_rand.coord.y + 1])
				index += 1
	
	for i in room_array:
		if count_adjacent_rooms(width, height, matrix, i.coord) == 1 && i.id == 1:
			i.id = 2
	
	for i in range(width):
		var sol_arr = []
		for j in range(height):
			sol_arr.append(length_matrix[i][j])
		print(sol_arr)
	
	return matrix
