extends RefCounted
class_name Items

enum Kinds {
	None,
	PlantA,
	PlantB,
	Coin
}

const List = [
	Kinds.None,
	Kinds.PlantA,
	Kinds.PlantB,
	Kinds.Coin
]

const none_probability = 100. / 1
const common_probability = 10. / 1
const rare_probability = 1. / 2

const probabilities = [
	none_probability,
	common_probability,
	rare_probability,
	rare_probability
]
