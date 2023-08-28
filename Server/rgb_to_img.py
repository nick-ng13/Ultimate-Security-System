import numpy as np
from PIL import Image

with open('data.txt') as f:
    lines = f.readlines()

lines = lines[0]

i = 0
x = 0
y = 0

# Generates png file based on the 140x100 photo sent from the De1-SoC
array = np.zeros([141, 101, 3], dtype=np.uint8)
while i < len(lines)-5:
    array[y][x] = [int("0x"+lines[i]+lines[i+1], 16),
                   int("0x"+lines[i+2]+lines[i+3], 16), int("0x"+lines[i+4] + lines[i+5], 16)]
    i = i + 6

    if x == 100 or lines[i:i+6] == "00FF00":
        if y == 140:
            break
        x = 0
        y = y + 1

        while lines[i:i+6] == "00FF00":
            i += 6
    else:
        x = x + 1

# for i in range(0, 8):
for j in range(len(array[0])-1, -1, -1):
    # Shift element of array by one
    array[3][j] = array[3][j-1]
    array[4][j] = array[4][j-2]
    array[5][j] = array[5][j-4]
    array[20][j] = array[20][j-1]
    array[21][j] = array[21][j-2]
    array[22][j] = array[22][j-4]
    array[38][j] = array[38][j-1]
    array[39][j] = array[39][j-2]
    array[40][j] = array[40][j-4]
    array[56][j] = array[56][j-1]
    array[57][j] = array[57][j-2]
    array[58][j] = array[58][j-4]
    array[74][j] = array[74][j-1]
    array[75][j] = array[75][j-2]
    array[76][j] = array[76][j-4]
    array[92][j] = array[92][j-1]
    array[93][j] = array[93][j-2]
    array[94][j] = array[94][j-4]
    array[110][j] = array[110][j-1]
    array[111][j] = array[111][j-2]
    array[112][j] = array[112][j-4]
    array[128][j] = array[128][j-1]
    array[129][j] = array[129][j-2]
    array[130][j] = array[130][j-4]


img = Image.fromarray(array)
img.save('testrgb.png')