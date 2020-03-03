class_name BigMask
extends Reference

const MASK_SIZE := 32
var bit_masks: PoolIntArray = []
var bits: int

func _init(size: int, default_state: bool = false, enforce_soft_size: bool = true) -> void:
	resize(size, default_state, enforce_soft_size)

func resize(size: int, default_state: bool = false, enforce_soft_size: bool = true) -> void:
	assert(size >= 0)
	var old_masks = bit_masks.size()
	bit_masks.resize(ceil(size / float(MASK_SIZE)))
	bits = size if enforce_soft_size else bit_masks.size() * MASK_SIZE
	for i in range(old_masks, bit_masks.size()):
		bit_masks[i] = ~0 if default_state else 0

func check_bit(index: int) -> bool:
	assert(index < bits)
	return bit_masks[index / MASK_SIZE] & (1 << (index % MASK_SIZE)) != 0

func set_bit(index: int, state: bool) -> void:
	assert(index < bits)
	if state:
		bit_masks[index / MASK_SIZE] |= (1 << (index % MASK_SIZE))
	else:
		bit_masks[index / MASK_SIZE] &= ~(1 << (index % MASK_SIZE))

func print_bits() -> void:
	for i in range(bits):
		print("bit " + String(i) + ": " + String(check_bit(i)))
