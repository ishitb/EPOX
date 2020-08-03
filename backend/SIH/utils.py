from PIL import Image
import glob

def areaPerc(annotation):
  dict = {"Linear Crack": {"Low": 0, "Medium": 0, "High": 0},
          "Alligator Crack": {"Low": 0, "High": 0}, 
          "Potholes": {"Low": 0, "Medium": 0, "High": 0},
          "Shoulders": {"Low": 0, "Medium": 0, "High": 0}}
  print(annotation)
  with open(annotation, 'r') as file: # opening file to read from
              lst = []
              lst = file.read().splitlines() 
              lst = list(filter(None, lst)) # list containing all the sentences
              file.close()
  words = []
  for sent in lst:
      words.append(sent.split(' ')) # splitting the sentences into words
  words = list(filter(None, words))

  for box in words:
      w = float(box[3]) 
      h = float(box[4])
      class_num = int(box[0])

      if class_num == 0:
        diam = 0.285 * w * h * 100
        if diam <= 2.41:
          dict["Linear Crack"]["Low"] = dict["Linear Crack"]["Low"] + diam
        elif diam > 2.42 and diam <= 4.80:
          dict["Linear Crack"]["Medium"] = dict["Linear Crack"]["Medium"] + diam
        else:
          dict["Linear Crack"]["High"] = dict["Linear Crack"]["High"] + diam

      elif class_num == 1:
        diam = w * h * 100
        if diam <= 33.5:
          dict["Alligator Crack"]["Low"] = dict["Alligator Crack"]["Low"] + diam
        else:
          dict["Alligator Crack"]["High"] = dict["Alligator Crack"]["High"] + diam

      elif class_num == 2:
        diam = 3.14 / 4 * max(w,h) * max(w,h)* 100
        if diam <= 26: #2.6
          dict["Potholes"]["Low"] = dict["Potholes"]["Low"] + diam
        elif diam > 26 and diam <= 52: #5.2
          dict["Potholes"]["Medium"] = dict["Potholes"]["Medium"] + diam
        else:
          dict["Potholes"]["High"] = dict["Potholes"]["High"] + diam

      elif class_num == 3:
        diam = w * h * 100
        if diam <= 8.3:
          dict["Shoulders"]["Low"] = dict["Shoulders"]["Low"] + diam
        elif diam > 8.3 and diam <= 16.7:
          dict["Shoulders"]["Medium"] = dict["Shoulders"]["Medium"] + diam
        else:
          dict["Shoulders"]["High"] = dict["Shoulders"]["High"] + diam
 
  return dict


#resizes anything with dimension >(720,720)
def ImResize(directory):
    filelist = glob.glob(directory + "*.jpg")
    for im in filelist:
        img = Image.open(im)
        width, height = img.size
        l = width - 720
        l = l/2
        cropped = img.crop((l, height - 720, l + 720, height))
        cropped.save(im)

def resizeImage(imageURL): #Indiviual Image Resize 
    img = Image.open(imageURL)
    width, height = img.size
    l = width - 720
    l = l/2
    cropped = img.crop((l, height - 720, l + 720, height))
    cropped.save(imageURL)

#PCI Calculation funct
def PCICalc(dictn):

  #defining MAEs
  MAE_ModErr = {"Linear Crack": {"Low": 5, "Medium": 5, "High": 10},
          "Alligator Crack": {"Low": 5, "High": 10}, 
          "Potholes": {"Low": 10, "Medium": 7, "High": 10},
          "Shoulders": {"Low": 10, "Medium": 5, "High": 10}}

  #calculating distress indexes
  LCI = 100 - 40*((dictn["Linear Crack"]["Low"]/MAE_ModErr["Linear Crack"]["Low"]) 
  + (dictn["Linear Crack"]["Medium"]/MAE_ModErr["Linear Crack"]["Medium"]) 
  + (dictn["Linear Crack"]["High"]/MAE_ModErr["Linear Crack"]["High"])) 

  ACI = 100 - 40*((dictn["Alligator Crack"]["Low"]/MAE_ModErr["Alligator Crack"]["Low"]) 
  + (dictn["Alligator Crack"]["High"]/MAE_ModErr["Alligator Crack"]["High"])) 

  PHI = 100 - 40*((dictn["Potholes"]["Low"]/MAE_ModErr["Potholes"]["Low"]) 
  + (dictn["Potholes"]["Medium"]/MAE_ModErr["Potholes"]["Medium"]) 
  + (dictn["Potholes"]["High"]/MAE_ModErr["Potholes"]["High"])) 

  SHI = 100 - 40*((dictn["Shoulders"]["Low"]/MAE_ModErr["Shoulders"]["Low"]) 
  + (dictn["Shoulders"]["Medium"]/MAE_ModErr["Shoulders"]["Medium"]) 
  + (dictn["Shoulders"]["High"]/MAE_ModErr["Shoulders"]["High"]))

  PCI = 100 * ((1 - ((1 - (LCI / 100)) * 0.355)) * (1 - ((1 - (ACI / 100)) * 0.355)) * (1 - ((1 - (PHI / 100)) * 0.262)) * (1 - ((1 - (SHI / 100)) * 0.355)))
  return PCI






def getPCI(filePath):
    noFaultPCI = 100 * ((1 - ((1 - (100 / 100)) * 0.355)) * (1 - ((1 - (100 / 100)) * 0.355)) * (1 - ((1 - (100 / 100)) * 0.262)) * (1 - ((1 - (100 / 100)) * 0.355)))
    PCIvalues = []
    print(filePath)
    dict = areaPerc(filePath)
    PCI = PCICalc(dict)
    PCIvalues.append(PCI)
    # for fil in glob.glob(filePath+"/" + "*.txt"):
    #   print("hello")

      
    if PCIvalues is None:
      PCIvalues.append(noFaultPCI)
    print("preopost")
    
    return PCIvalues
