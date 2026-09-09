extends RefCounted

class_name GridCore

class GridCell:
	var cell

var rows = 10
var cols = 10
# array of array of GridCell
var grid: Array = [] 

static func create(new_rows: int, new_cols: int) -> GridCore:
	var new = GridCore.new()
	new.grid = []
	new.rows = new_rows
	new.cols = new_cols
	for i in range(new.rows):
		new.grid.append([])
		for j in range(new.cols):
			new.grid[i].append(GridCell.new())
			
	return new
