import os
from flask import Flask, flash, request, redirect, url_for,make_response,jsonify,send_from_directory
from werkzeug.utils import secure_filename
from .utils import getPCI


UPLOAD_FOLDER = '/home/abhisht/Desktop/SIH-flask/images' # Absolute path to 'images' directory 
OUTPUT_FOLDER = '/home/abhisht/Desktop/SIH-flask/inference/output/'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

app = Flask(__name__)
weightPath = '/home/abhisht/Desktop/SIH-flask/weights.pt' # Absolute path to weights.pt in the project 
script = 'python yolov5/detect.py --weights '+weightPath+' --img 736 --save-txt --conf 0.2 --source ' 

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def index():
    return 'aur bhai'

@app.route('/hmm')
def index1():
    return 'tu bata'

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/image-upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            return make_response(jsonify({"message":"dukh"}),401)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            return make_response(jsonify({"message":"bhai file should have a name"}),401)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)

            # if(os.path.join(app.config['UPLOAD_FOLDER'],filename)):
            #     return make_response(jsonify({"message":"exist"}),200)
                
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            try:
                filePath = app.config['UPLOAD_FOLDER']+"/"+filename
                print(filePath)
                os.system(script+filePath)
                filename1 = filename[:-4]
                PCI = getPCI(OUTPUT_FOLDER+filename1+".txt")
                print(PCI)
            except:
                return make_response(jsonify({"message:Check again"}))
            return make_response(jsonify({
                "message":"success",
                "data":PCI
                 }),201)
        else:
            return make_response(jsonify({"message":"failed, prolly file type is wrong"}),200)

@app.route('/getresults')
def uploaded_file():
    if request.is_json:
        filename = request.get_json()['file']

        if filename == '':
            return make_response(jsonify({"message":"bhai file should have a name"}),401)
        # if not (os.path.join(app.config['UPLOAD_FOLDER'],filename)):
        #         return make_response(jsonify({"message":"File does not exist"}),200)
        return send_from_directory(app.config['UPLOAD_FOLDER'],
                               filename)
    else:
        return make_response(jsonify({"message":"bad request"}),401)