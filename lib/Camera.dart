// ignore: avoid_web_libraries_in_flutter

import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class Camera extends StatefulWidget {
  final File myImage;

  const Camera({Key key,@required this.myImage}) : super(key: key);
  @override
  _CameraState createState() => _CameraState(myImage);
}

class _CameraState extends State<Camera> {
File myImage;
String ftext="";
List<String> list=[];
_CameraState(this.myImage){
  OCRreader();
}

  OCRreader()async{
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(myImage);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    await textRecognizer.close();
    String text = visionText.text;
    List<String> tlist=[];


    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
        for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          tlist.add(element.text);
        }
      }
    }
    for(String a in list){
      print(a);
    }
    setState(() {
      ftext= text;
      list=tlist;
    });
  }
Widget showData(){
  if(list.length<=0){return Text("NO DATA FOUND");}
  else{
  return Expanded(child:
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    child: ListView.separated(

      padding: const EdgeInsets.all(2),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(

          height: 40,
          color: Colors.white70,
          child: Center(child: Text('${list[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 2,
      ),
    ),
  ),

  );}
}

  
  Widget createWidget(){
    if(myImage==null)
      {
        return Text("Image not Found");
      }
    else {
      return ConstrainedBox(child:Stack(children: [Container(color: Colors.white70,),Center(child: PinchZoom(image: Image.file(myImage),zoomedBackgroundColor: Colors.black54,),)],),constraints: BoxConstraints(maxWidth: 350,maxHeight: 350),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        iconTheme: IconThemeData(color:Colors.white, size: 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),

        ),

// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
        title: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("Assets/Logo.png",height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("DIV"),
              )
            ],
          ),
        ),
      ),
      body: Center(
// Center is a layout widget. It takes a single child and positions it
// in the middle of the parent.
        child: Column(
// Column is also a layout widget. It takes a list of children and
// arranges them vertically. By default, it sizes itself to fit its
// children horizontally, and tries to be as tall as its parent.
//
// Invoke "debug painting" (press "p" in the console, choose the
// "Toggle Debug Paint" action from the Flutter Inspector in Android
// Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// to see the wireframe for each widget.
//
// Column has various properties to control how it sizes itself and
// how it positions its children. Here we use mainAxisAlignment to
// center the children vertically; the main axis here is the vertical
// axis because Columns are vertical (the cross axis would be
// horizontal).

          children: <Widget>[
            Padding(padding:EdgeInsets.symmetric(vertical: 10)),
            Text('Image OCR',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Padding(padding:EdgeInsets.symmetric(vertical: 10)),
            createWidget(),
            showData()




          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

