import 'dart:io';    
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore    
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';    
import 'package:image_picker/image_picker.dart'; // For Image Picker    
import 'package:image_cropper/image_cropper.dart'; 
import 'package:path/path.dart' as Path;  



class Upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ImageCapture(),
    );
  }
}







class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  
  File _imageFile;    
  Future<void> _pickImage(ImageSource source) async {
    File selected =  await ImagePicker.pickImage(source: source);
  
  setState(() {
    _imageFile = selected;
  });
  }

  void _clear(){
    setState(() => _imageFile = null);
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
   return 
  Scaffold(
     bottomNavigationBar: BottomAppBar(
       child: Row(
         children: <Widget>[
           IconButton(
             icon: Icon(Icons.photo_camera),
             onPressed: ()=> _pickImage(ImageSource.camera),
           ),
           IconButton(
              icon: Icon(Icons.photo_library),
               onPressed: ()=> _pickImage(ImageSource.gallery),

           ),
       ],),
     ),
     body: ListView(
       children: <Widget>[
         if(_imageFile != null) ...[
           Image.file(_imageFile),
           Row(children: <Widget>[
             FlatButton(
              onPressed: _clear, 
              child: Icon(Icons.refresh)
            ),   
           ],
          ),

        Uploader(file: _imageFile)
         ],
       ],
     ),
    ); 
  }

 
}
class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key:key);
  
  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = 
        FirebaseStorage(storageBucket: "gs://gohair-7957b.appspot.com");

        StorageUploadTask _uploadTask;
        void _startUpload(){
          String filePath = 'images/${DateTime.now()}.png';
          setState(() {
            _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
          });
        }  
  
  
  
  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot){
          var event = snapshot?.data?.snapshot;

          double progressPercent = event !=null
          ? event.bytesTransferred / event.totalByteCount
          :0;

          return Column(children: <Widget>[
             if(_uploadTask.isComplete)
             Text('congrat :)'),

               if(_uploadTask.isPaused)
               FlatButton(
                 onPressed: _uploadTask.resume, 
                 child: Icon(Icons.play_arrow)
                 ),

                 LinearProgressIndicator(value: progressPercent, ),
                 Text(
                   '${(progressPercent * 100). toStringAsFixed(2)} %'
                 ),
          ],);


        });

    }else{
        return FlatButton.icon(
          label: Text('upload to firebase'),
          icon: Icon(Icons.cloud_upload),
          onPressed: _startUpload,
        );

      }

  }
}



 