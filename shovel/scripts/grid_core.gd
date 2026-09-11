extends RefCounted

class_name GridCore

const MaxTurns = 5

var rows = 10
var cols = 10
# array of array of GridCell
var grid: Array = [] 
var rndg: RandomNumberGenerator

var turns = MaxTurns
var current_dig: Shovel.Kinds
var next_dig: Shovel.Kinds
var rotate: int = 0

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
	rndg = RandomNumberGenerator.new()
	
	for i in range(rows * cols):
		var index = rndg.rand_weighted(Items.probabilities)
		grid[i].item = Items.List[index]
		
	#current_dig = Shovel.Kinds.Rect2x3
	#next_dig = Shovel.Kinds.Rect1x1
	current_dig = Shovel.List[rndg.rand_weighted(Shovel.probabilities)]
	next_dig = Shovel.List[rndg.rand_weighted(Shovel.probabilities)]

func rotate_shovel():
	rotate = (rotate + 1) % 4

func dig(pivot: Vector2i):
	if is_over():
		return 
		
	var area = Shovel.get_area(current_dig, pivot, rows, cols, rotate)
	
	for value in area:		
		var cell = grid[value.x * cols + value.y]
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
	if turns > 1:
		next_dig = Shovel.List[rndg.rand_weighted(Shovel.probabilities)] 
	else:
		next_dig = Shovel.Kinds.None
	rotate = 0

func is_over():
	return turns <= 0
	
func finish():
	InventoryAutoload.add_items(got_items)
	print("add items", got_items)
	return
