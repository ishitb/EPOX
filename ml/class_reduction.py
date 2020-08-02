import os

names= ["D00", "D01", "D10", "D11", "D20", "D40", "D43", "D44"]

actualNames = ['Linear crack(0-3)','Alligator crack 4','Potholes 5','Shoulders']

linCrack = ['0','1','2','3']


count = 0 
directory = '/home/abhisht/Desktop/fox_trading/train_ann'
# directory = '/home/abhisht/Desktop/fox_trading/tryOutdir'

for entry in os.scandir(directory):
    if (entry.path.endswith(".txt")):
        # print(type(entry.path))
        stringArr = []
        with open(entry.path,'r') as reader:
            for lines in reader.readlines():
                if lines[0] in linCrack:
                    lines = '0'+lines[1:]
                elif lines[0] == '4':
                    lines = '1'+lines[1:]
                elif lines[0]=='5':
                    lines = '2'+lines[1:]
                else:
                    lines = '3'+lines[1:]
                stringArr.append(lines)
            
            with open(entry.path,'w') as f:
                for line in stringArr:
                    f.write(line)
                f.close()
            reader.close()

            
        count+=1

print(count)
print("Success!")