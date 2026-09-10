extends RefCounted

class_name GridCore

const MaxTurns = 5

var rows = 10
var cols = 10
# array of array of GridCell
var grid: Array = [] 

var turns = MaxTurns
var current_dig: Shovel.Kinds
var next_dig: Shovel.Kinds

var got_items = {} # Items.Kinds : int

static func create(new_rows: int, new_cols: int) -> GridCore:
	var new = GridCore.new()
	new.grid = []
	new.rows = new_rows
	new.cols = new_cols
	for i in range(new.rows * new.cols):
		var cell = GridCell.new()
		cell.i = i / new_rows
		cell.j = i % new_cols
		new.grid.append(cell)
			
	return new

func init_game(): 
	var randg = RandomNumberGenerator.new()
	
	for i in range(rows * cols):
		var index = randg.rand_weighted(Items.probabilities)
		grid[i].item = Items.List[index]
		
	current_dig = Shovel.Kinds.Rect1x1
	next_dig = Shovel.Kinds.Rect1x1
	#current_dig = Shovel.List[randg.rand_weighted(Shovel.probabilities)]
	#next_dig = Shovel.List[randg.rand_weighted(Shovel.probabilities)]

func dig(pivot: Vector2i):
	if is_over():
		return 
		
	var area = Shovel.get_area(current_dig, pivot)
	
	for i in range(len(area)):
		var coord = area[i]
		if coord.x < 0 || coord.x >= rows || \
			coord.y < 0 || coord.y >= cols:
			continue
		
		var cell = grid[coord.x * cols + coord.y]
		if not cell:
			continue
			
		if (not cell.digged) && cell.item != Items.Kinds.None:
			var count = 0
			if got_items.has(cell.item):
				count = got_items[cell.item]
			got_items[cell.item] = count + 1
			
		cell.digged = true

	turns = turns - 1
	current_dig = next_dig
	next_dig = Shovel.Kinds.Rect1x1

func is_over():
	print("it over, isn't it? ", turns <= 0)
	return turns <= 0
	
func finish():
	#add got items to Inventory
	return
