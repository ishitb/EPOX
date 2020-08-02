import os
import random 

c=0
files = []
with open('empty.txt') as f:
    line = f.readline()
    while(line):
        # print(line[2:-5])
        files.append(line[2:-5])
        line = f.readline()
        c+=1
    print(c)


# for file in files:
#     print(file)
print(len(files))

print('India_000001' in files)

for i in range(2000):
    file = random.choice(files)
    if os.path.exists("/home/abhisht/Desktop/fox_trading/train_ann/"+file+".txt") and os.path.exists("/home/abhisht/Desktop/fox_trading/train_img/"+file+".jpg"):
        os.remove("/home/abhisht/Desktop/fox_trading/train_ann/"+file+".txt")
        os.remove("/home/abhisht/Desktop/fox_trading/train_img/"+file+".jpg")
    else:
        print("The file does not exist")
        continue
    # print(random.choice(files))
    files.remove(file)

print(len(files))


