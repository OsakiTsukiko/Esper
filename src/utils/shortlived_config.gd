extends Node

var map_width: int = 20
var map_height: int = 20
var map_room_number: int
var map_SB_distance: int

#-1 - unused room
# 0 - start room
# 1 - mid room
# 2 - dead end room
# 3 - boss room
var map_matrix: Array

# 0 - start
var map_length_matrix: Array


# 8 4
# 13 6
# 20 10	
func create_map(room_number, distance):
	map_room_number = room_number
	map_SB_distance = distance
	map_matrix = MapGen.generate_map_matrix(map_width, map_height, map_room_number, map_SB_distance)
	for i in range(map_matrix.size()):
		var sol_array = []
		for j in range(map_matrix[i].size()):
			sol_array.append(map_matrix[i][j].id)
#		print(sol_array)
	Gamestate.begin()
