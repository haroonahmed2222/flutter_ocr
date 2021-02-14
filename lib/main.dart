import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'Camera.dart';
import 'ScaleRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIV',


      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color.fromRGBO(242, 242, 242, 1),
        fontFamily: 'Roboto',

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(){
    imageCache.clear();
  }
  File _image;
  final picker = ImagePicker();

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {

      _image = File(pickedFile.path);
      Navigator.push(context,  ScaleRoute(page: Camera(myImage: _image,)));

    });
  }
  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {

      _image = File(pickedFile.path);
      Navigator.push(context,  ScaleRoute(page: Camera(myImage: _image,)));

    });
  }
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return Scaffold(
      drawer: Drawer(

        child: ListView(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: Text("DASHBOARD",

                style: TextStyle(

                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            Divider(color: Colors.black12,thickness: 1,)
          ],
        ),
      )
      ,
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
              SvgPicture.asset("Assets/Logo.svg",color: Colors.white,height: 30,),
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

          children: [
            Padding(padding:EdgeInsets.symmetric(vertical: 10)),

            Text('Image OCR',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

            Padding(padding:EdgeInsets.symmetric(vertical: 10)),
  Container(
    child:     Expanded(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [

                   Container(

                     margin: EdgeInsets.symmetric(vertical: 20),

                     child: MaterialButton(onPressed: () { getImageCamera(); },



                       shape: RoundedRectangleBorder(

                           borderRadius: BorderRadius.all(Radius.circular(10))),

                       child: ConstrainedBox(

                         constraints: BoxConstraints(maxWidth: 300,minWidth: 300),

                         child: Row(



                           mainAxisAlignment: MainAxisAlignment.spaceAround,

                           children: [

                             Icon(Icons.camera_alt,size: 40,),

                             Padding(

                               padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 50),

                               child: Text("Camera",

                                 style: TextStyle(

                                     fontWeight: FontWeight.bold,

                                     fontSize: 20

                                 ),),

                             ),

                             Icon(Icons.arrow_right,size: 40,),

                           ],

                         ),

                       ),

                       color: Colors.white,

                       textColor: Colors.black,



                     ),

                   ),

                   Container(

                     margin: EdgeInsets.symmetric(vertical: 20),

                     child: MaterialButton(onPressed: () { getImageGallery(); },

                       shape: RoundedRectangleBorder(

                           borderRadius: BorderRadius.all(Radius.circular(10))),

                       child: ConstrainedBox(

                         constraints: BoxConstraints(maxWidth: 300,minWidth: 300),

                         child: Row(



                           mainAxisAlignment: MainAxisAlignment.spaceAround,

                           children: [

                             Icon(Icons.image,size: 40,),

                             Padding(

                               padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 50),

                               child: Text("Gallery",

                                 style: TextStyle(

                                     fontWeight: FontWeight.bold,

                                     fontSize: 20

                                 ),),

                             ),

                             Icon(Icons.arrow_right,size: 40,),

                           ],

                         ),

                       ),

                       color: Colors.white,

                       textColor: Colors.black,



                     ),

                   ),
                 ],
                )



    
    
    ),
  ),
],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
