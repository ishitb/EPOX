# Making Road Damage analysis smarter and easier


### This repo consists of the code for 
  1. The mobile application
  2. Backend 
  3. Admin dashboard
  4. Machine learning scripts and models

## Mobile Application
An app with a very intuitive user interface so than anyone is able to use it to report any kind of road damages just by clicking a picture.

*To run the source code and test the app:-*
> Requirements :
> Make sure you have adb installed on your system and also Flutter v1.21.0 from the [master channel](https://www.github.com/flutter/flutter). 
> Before starting the app make sure you have a device connected over the adb.
* Clone the repository to your system
* Open Terminal and navigate to **App** Folder
* Run **flutter pub get** to install the flutter libraries used in the project.
* Run **flutter run** to start the application on you connected device.

![](https://github.com/ishitb/NC_SVCE_MK199_EPOX/blob/master/app/ui.gif)  

[screenshot 2](https://github.com/ishitb/NC_SVCE_MK199_EPOX/blob/master/app/appdemo.gif)
### Dataset Link

> [RoadDamageDataset](https://mycityreport.s3-ap-northeast-1.amazonaws.com/02_RoadDamageDataset/public_data/Japan/RDD2020_data.tar.gz)

## Starting The Backend 

### To run the flask backend for the project follow the steps 

  1. Environment Setup : To create a virtual environment and installation of flask on your system follow [this link](https://flask.palletsprojects.com/en/1.1.x/installation/)
  2. You need to clone [the YOLO V5 repository](https://github.com/ultralytics/yolov5) as well in the backend directory.

 > git clone https://github.com/ultralytics/yolov5
 
 > cd yolov5
 
 > git reset --hard 5ba1de0cdcc414c69ceb7a4c45eb1e3895eca32a
 
 > cd ..
 
 3. To run the flask server on (localhost:5000) type:
 
 > flask run 
 
### Flask Structure
```
.
├── images
│   └── India_000061.jpg
├── inference
│   └── output
│       ├── India_000061.jpg
│       └── India_000061.txt
├── ngrok
├── requirements.txt
├── SIH
│   ├── __init__.py
│   └── utils.py
├── start.txt
└── weights.pt


```


## Admin Dashboard
A web browser based admin dashboard which would make it easier for the authorities to keep a record of the location of the damages on roads and the status of the complaint

To see the demo open the frontend folder and read the README

*To run the source code and test the Webapp:-*
1. Clone the repository to your system
1. Open Terminal and navigate to **Frontend** Folder
1. Run **npm install** to install the dependencies
1. Run **npm start** to start the application
1. Login with appropriate credentials for the app
1. Get the data of all roads, their PCI, location, rating, trends and much more on your fingertips
1. Profit

Note: The application will boot in your default browser, in the last active window, by default on localhost:3000 

![](https://github.com/ishitb/NC_SVCE_MK199_EPOX/blob/master/frontend/admin_panel_gif-min.gif)
