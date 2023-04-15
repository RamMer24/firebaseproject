

import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ADDPRODUCT extends StatefulWidget {


  @override
  State<ADDPRODUCT> createState() => _ADDPRODUCTState();
}

class _ADDPRODUCTState extends State<ADDPRODUCT> {

  TextEditingController _productname = TextEditingController();
  TextEditingController _price =TextEditingController();


  var selected="Gj";
  var grp="simple";
  ImagePicker _picker = ImagePicker();

  File? selectedimage;

  bool isloading=false;


  _handalRadio(val)
  {
    setState(() {
      grp = val!;
    });
  }
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Addproduct"),
        ),
        body: (isloading)?Center(
          child: CircularProgressIndicator(),
        ):SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [

                      (selectedimage==null)?
                      Image.network("https://cdn.pixabay.com/photo/2023/03/09/16/00/rose-7840331__480.jpg",fit: BoxFit.cover,width: 50,height: 50,)
                          :Image.file(selectedimage!,width: 100.0,),
                      IconButton(onPressed: () async{
                        XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                        setState(() {
                          selectedimage = File(photo!.path);
                        });

                      }, icon:Icon(Icons.camera_alt)),
                      IconButton(onPressed: () async{
                        XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          selectedimage = File(photo!.path);
                        });
                      }, icon:Icon(Icons.browse_gallery)),
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("productname",style: TextStyle(fontSize: 20),),
                TextField(
                  controller: _productname,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                    focusedBorder:   OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                  ),

                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10.0,),
                Text("PRICE",style: TextStyle(fontSize: 20),),
                TextField(
                  controller: _price,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                    focusedBorder:   OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                  ),

                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("category"),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      value: selected,
                      onChanged: (val){
                        setState(() {
                          selected=val!;
                        });
                      },
                      items: [

                        DropdownMenuItem(
                          child: Text("Gujrat"),
                          value: "Gj",
                        ),
                        DropdownMenuItem(
                          child: Text("Maharastra"),
                          value: "MH",
                        ),
                        DropdownMenuItem(
                          child: Text("Punjab"),
                          value: "PJ",
                        ),
                        DropdownMenuItem(
                            child: Text("Delhi"),
                            value: "DL"
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: "simple",
                      groupValue: grp,
                      onChanged: _handalRadio,

                    ),
                    Text("simple"),
                    Radio(
                      value: "varible",
                      groupValue: grp,
                      onChanged: _handalRadio,

                    ),
                    Text("varible"),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async{

                      setState(() {
                        isloading=true;
                      });
                      var name = _productname.text.toString();
                      var price= _price.text.toString();
                      var category = selected.toString();
                      var type = grp.toString();

                      //upload
                      var uuid = Uuid();
                      var filename = uuid.v1();

                      await FirebaseStorage.instance.ref(filename)
                          .putFile(selectedimage!).whenComplete((){}).then((filedata) async{
                            await filedata.ref.getDownloadURL().then((fileurl) async{
                              await FirebaseFirestore.instance.collection("Products").add({
                                "productname":name,
                                "price":price,
                                "category":category,
                                "type":type,
                                "filename":filename,
                                "fileurl":fileurl
                              }).then((value){
                                print("Data Added");
                                _productname.text="";
                                _price.text="";
                                setState(() {
                                   selected="Gj";
                                   grp="simple";
                                   selectedimage=null;
                                   isloading=false;
                                });
                              });
                            });
                      });





                    },
                    child: Text("ADD"),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
