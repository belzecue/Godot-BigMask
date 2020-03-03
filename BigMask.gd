class_name BigMask
extends Reference

const MASK_SIZE := 32
var bit_masks: PoolIntArray = []

func _init(size: int, default_state: bool) -> void:
	bit_masks.resize(ceil(size / float(MASK_SIZE)))
	if default_state:
		for i in range(bit_masks.size() - 1):
			bit_masks[i] = ~0
		bit_masks[bit_masks.size() - 1] = ~((~0) << (size % MASK_SIZE))
	else:
		for i in range(bit_masks.size()):
			bit_masks[i] = 0

func check_bit(index: int) -> bool:
	return bit_masks[index / MASK_SIZE] & (1 << (index % MASK_SIZE)) != 0

func enable_bit(index: int) -> void:
	bit_masks[index / MASK_SIZE] |= (1 << (index % MASK_SIZE))

func disable_bit(index: int) -> void:
	bit_masks[index / MASK_SIZE] &= ~(1 << (index % MASK_SIZE))

func print_bits() -> void:
	for i in range(bit_masks.size() * MASK_SIZE):
		print("bit " + String(i) + ": " + String(check_bit(i)))
