import sys

if not(sys.argv[1]):
	last = 20
else:
	last = 1+int(sys.argv[1],16)/4

x1 = 0
x2 = 1
for i in range(last):
	print i,'-',x1," - ",hex(x1)
	# print x2
	temp = x1+x2
	x1 = x2
	x2 = temp