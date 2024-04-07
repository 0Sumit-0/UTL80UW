import 'dart:io';

import 'package:customm/services/database_service.dart';
import 'package:customm/shared/constraint.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constraints.apikey,
          appId: Constraints.appId,
          storageBucket: Constraints.storageBucket,
          messagingSenderId: Constraints.messageSenderId,
          projectId: Constraints.projectId),);
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constraints.apikey,
          appId: Constraints.appId,
          storageBucket: Constraints.storageBucket,
          messagingSenderId: Constraints.messageSenderId,
          projectId: Constraints.projectId),);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}


bool _notHaveEnoughData=false;

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  CustomWidget? widgetsToBeAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: const BoxDecoration(color: Colors.white70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8.0),
                      child: widgetsToBeAdded ?? const Center(child: Text("No widget is Added")),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  widgetsToBeAdded= await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondScreen()),
                  ) as CustomWidget?;

                  // print(widgetsToBeAdded?.textWidget);
                  widgetsToBeAdded ??= const CustomWidget();

                  setState(() {
                    _notHaveEnoughData=false;
                  });
                },
                child: const Text('Add Widgets'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  List<int> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
            child: CheckboxListTile(
              title: const Text('Text Widget'),
              value: selectedOptions.contains(0),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedOptions.add(0);
                  } else {
                    selectedOptions.remove(0);
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
            child: CheckboxListTile(
              title: const Text('Image Widget'),
              value: selectedOptions.contains(1),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedOptions.add(1);
                  } else {
                    selectedOptions.remove(1);
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
            child: CheckboxListTile(
              title: const Text('Button Widget'),
              value: selectedOptions.contains(2),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedOptions.add(2);
                  } else {
                    selectedOptions.remove(2);
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              if (kDebugMode) {
                print('Selected Options: $selectedOptions');
              }

              bool hastext=false;
              bool hasimage=false;
              bool hassavebutton=false;
              for (var element in selectedOptions) {
                if(element==0){
                  hastext=true;
                }else if(element==1){
                  hasimage=true;
                }else if(element==2){
                  hassavebutton=true;
                }
              }


              Navigator.pop(context,CustomWidget(textWidget: hastext,imageWidget: hasimage,saveButton: hassavebutton,));
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            child: const Text("Import Widgets"),
          )
        ],
      ),
    );
  }
}

class CustomWidget extends StatefulWidget {
  final bool textWidget;
  final bool imageWidget;
  final bool saveButton;
  const CustomWidget({super.key, this.textWidget=false, this.imageWidget=false, this.saveButton=false});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  final TextEditingController textController = TextEditingController();


  File? _imageFile;
  String? _imageURL;
  bool _isLoading=false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        // _selected=true;
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  Future<bool?> upload()async{
    if(_imageFile!=null){
      setState(() {
        _isLoading=true;
      });
      _imageURL = await DatabaseService().uploadImageToFirebase(_imageFile!);

    }

    if (_imageURL != null) {
      if (kDebugMode) {
        print('Image uploaded successfully. URL: $_imageURL');
      }
    } else {
      if (kDebugMode) {
        print('Failed to upload image.');
      }

    }

    //update on database

    var result=DatabaseService().createPost(_imageURL ?? '', textController.text);

    if(result!=null){
      print("Success");
      setState(() {
        textController.text='';
        _imageURL=null;
        _imageFile=null;
        _isLoading=false;
      });
    }else{
      print("failed");
      _isLoading=false;
    }


  }

  @override
  Widget build(BuildContext context) {
    return _isLoading?
    const Center(child: CircularProgressIndicator(),)
        :
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.textWidget==true?Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: const InputDecoration(
                  hintText: "Enter Text",
                  labelText: "TextWidget",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              controller: textController,
            ),
          ):const SizedBox(),
          const SizedBox(
            height: 30,
          ),
          widget.imageWidget==true?InkWell(
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white12,
              ),
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      width: 150,
                      height: 150,
                    )
                  : InkWell(
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Colors.white12,
                          ),
                          child: const Center(child: Text("Pick Image"))),
                    ),
            ),
          ):const SizedBox(),
          _notHaveEnoughData?const Center(child: Text("Add at-least a widget to save")): const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          widget.saveButton==true?Center(
            child: ElevatedButton(
              onPressed: (){
                if(widget.saveButton & ((widget.textWidget==false) & (widget.imageWidget==false))){
                  _notHaveEnoughData=true;
                  setState(() {

                  });

                }else{
                  upload();
                }

              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),

              child: const Text("Save"),
            ),
          ): const SizedBox(),
        ],
      ),
    );
  }
}
