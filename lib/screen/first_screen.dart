import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database_service.dart';



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
        title: const Center(child: Text('Assignment App',style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.white70,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: const BoxDecoration(color: Colors.greenAccent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8.0),
                        child: widgetsToBeAdded ?? const Center(child: Text("No widget is Added",style: TextStyle(fontSize: 30),)),
                      ),
                    ],
                  ),
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
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.black)
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(CupertinoColors.activeGreen),
                ),
                child: const Text('Add Widgets',style: TextStyle(color: CupertinoColors.black),),
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
  bool _isSelectedText=false;
  bool _isSelectedImage=false;
  bool _isSelectedButton=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.greenAccent,
      body: ListView(
        children: [
          const SizedBox(height: 30,),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
              child: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width/1.5,
                height: 40,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        if(_isSelectedText){
                          _isSelectedText=false;
                        }else{
                          _isSelectedText=true;
                        }

                        setState(() {
                          if (_isSelectedText) {
                            selectedOptions.add(0);
                          } else {
                            selectedOptions.remove(0);
                          }
                        });
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            color: Colors.white70,
                          ),
                          Center(
                            child: CircleAvatar(
                              maxRadius: 15,
                              backgroundColor: _isSelectedText ? Colors.greenAccent : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20,),
                    const SizedBox(
                      height: 40,
                      child: Center(child: Text('Text Widget',style: TextStyle(color: CupertinoColors.black,fontSize: 15),)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
              child: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width/1.5,
                height: 40,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        if(_isSelectedImage){
                          _isSelectedImage=false;
                        }else{
                          _isSelectedImage=true;
                        }

                        setState(() {
                          if (_isSelectedImage) {
                            selectedOptions.add(1);
                          } else {
                            selectedOptions.remove(1);
                          }
                        });
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            color: Colors.white70,
                          ),
                          Center(
                            child: CircleAvatar(
                              maxRadius: 15,
                              backgroundColor: _isSelectedImage ? Colors.greenAccent : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20,),
                    const SizedBox(
                      height: 40,
                      child: Center(child: Text('Image Widget',style: TextStyle(color: CupertinoColors.black,fontSize: 15),)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
              child: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width/1.5,
                height: 40,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        if(_isSelectedButton){
                          _isSelectedButton=false;
                        }else{
                          _isSelectedButton=true;
                        }

                        setState(() {
                          if (_isSelectedButton) {
                            selectedOptions.add(2);
                          } else {
                            selectedOptions.remove(2);
                          }
                        });
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            color: Colors.white70,
                          ),
                          Center(
                            child: CircleAvatar(
                              maxRadius: 15,
                              backgroundColor: _isSelectedButton ? Colors.greenAccent : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20,),
                    const SizedBox(
                      height: 40,
                      child: Center(child: Text('Button Widget',style: TextStyle(color: CupertinoColors.black,fontSize: 15),)),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width/1.5,
              child: ElevatedButton(
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
                        side: const BorderSide(color: Colors.black)
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(CupertinoColors.activeGreen),
                ),
                child: const Text("Import Widgets",style: TextStyle(color: CupertinoColors.black),),
              ),
            ),
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
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: "Enter Text",
                  labelText: "TextWidget",
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
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
                      color: Colors.grey,
                    ),
                    child: const Center(child: Text("Upload Image"))),
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
                      side: const BorderSide(color: Colors.black)
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(CupertinoColors.activeGreen),
              ),

              child: const Text("Save",style: TextStyle(color: CupertinoColors.black),),
            ),
          ): const SizedBox(),
        ],
      ),
    );
  }
}
