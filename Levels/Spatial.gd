extends Spatial
#	
#	+-----+-----+-----+
#   | NO  |  N  |  NE |
#	+-----+-----+-----+
#   |  O  | -X- |  E  |
#	+-----+-----+-----+
#   | SO  |  S  |  SE |
#	+-----+-----+-----+
#
#
#
#
#
#
const N = Vector3(0,0,-1)
const E = Vector3(1,0,0)
const S = Vector3(0,0,1)
const O = Vector3(-1,0,0)
const NO = N+O
const NE = N+E
const SO = S+O
const SE = S+E

var map = [
	[[E,SE,S],[O,E,SO,S],[O,E],[O,E,S],[O]],
	[[N,NE,E,SE,S],[NO,N,O,SO,S],[E],[N,S,O],[S]],
	[[N,NE,E,SE,S],[NO,N,O,E,SO,S,SE],[O,SO,S],[N],[N,S]],
	[[N,NE,E],[NO,N,NE,O,E],[NO,N,O,E],[O,E],[N,O]]
]

var astarSimple = null

var all_points = {}
var astarIntance = null
var mapTilesInd = []
onready var gridmap = $GridMap
func _ready():
	astarIntance = AStar.new()
	var lineIndex = 0
	while lineIndex < map.size():
		var colIndex = 0
		mapTilesInd.push_back([])
		while colIndex < map[lineIndex].size():
			var ind = astarIntance.get_available_point_id()
			astarIntance.add_point(ind, Vector3(colIndex*2, 0, lineIndex*2)) # pourquoi gridMap ?
			mapTilesInd[lineIndex].push_back(ind)
			print(str(map[lineIndex][colIndex]))
			colIndex += 1
		lineIndex += 1
		
	lineIndex = 0
	while lineIndex < map.size():
		var colIndex = 0
		while colIndex < map[lineIndex].size():
			var ind1 = mapTilesInd[lineIndex][colIndex]
			for  connection in map[lineIndex][colIndex]:
				var ind2 = mapTilesInd[lineIndex+connection[2]][colIndex+connection[0]]
				astarIntance.connect_points(ind1, ind2, false)
			colIndex += 1
		lineIndex += 1

func v3_to_index(v3):
	return str(int(round(v3.x))) + "," + str(int(round(v3.y))) + "," + str(int(round(v3.z)))
	
func get_path_astart(start, end):
	if start[0] < 0:
		start[0] = start[0]*-1
	if start[2] < 0:
		start[2] = start[2]*-1
	if end[0] < 0:
		end[0] = end[0]*-1
	if end[2] < 0:
		end[2] = end[2]*-1
	print("Start: "+str(round(start[2])/2)+","+str(round(start[0])/2))
	print("End: "+str(round(end[2])/2)+","+str(round(end[0])/2))
	var endTile = mapTilesInd[round(end[2])/2][round(end[0])/2]
	var startTile = mapTilesInd[round(start[2])/2][round(start[0])/2]
	print("start => "+str(start)+str(startTile)+" | end => "+str(end)+str(endTile))
	return astarIntance.get_point_path(startTile, endTile)
