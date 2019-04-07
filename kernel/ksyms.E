	.data
	.globl	_symbol_table_size, _symbol_table

_symbol_table_size:
	.long 3

_symbol_table:
	.long current
	.long strings+0
	.long jiffies
	.long strings+8
	.long printk
	.long strings+16

strings:
	.ascii "current\0"
	.ascii "jiffies\0"
	.ascii "printk\0"
