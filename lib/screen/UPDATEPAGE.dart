import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproject/screen/VIEWPRODUCT.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UPDATEPAGE extends StatefulWidget {

  var updateid="";
  UPDATEPAGE({required this.updateid});
  @override
  State<UPDATEPAGE> createState() => _UPDATEPAGEState();
}

class _UPDATEPAGEState extends State<UPDATEPAGE> {
  TextEditingController _productname = TextEditingController();
  TextEditingController _price = TextEditingController();

  var selected = "Gj";
  var grp = "simple";

  _handalRadio(val) {
    setState(() {
      grp = val!;
    });
  }

  var oldimagename="";
  var oldimageurl="";

  bool isloading=false;

  getsingle() async
  {
    await FirebaseFirestore.instance.collection("Products").doc(widget.updateid)
        .get().then((document){
      _productname.text = document["productname"];
      _price.text = document["price"];
      setState(() {
        grp = document["type"];
        selected =document["category"];
        oldimageurl=document["fileurl"];
        oldimagename=document["filename"];
      });
    });
  }
  ImagePicker _picker = ImagePicker();
  File? selectedimage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsingle();
  }

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("updatepage"),
        ),
        body: (isloading)?Center(
          child: CircularProgressIndicator(),
        ):SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (selectedimage==null)?(oldimageurl!="")?Image.network(
                        oldimageurl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ):Image.network("https://cdn.pixabay.com/photo/2023/03/09/16/00/rose-7840331__480.jpg",fit: BoxFit.cover,width: 50,height: 50,)
                          :Image.file(selectedimage!,width: 100.0,),
                      IconButton(
                          onPressed: () async{
                            XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                            setState(() {
                              selectedimage = File(photo!.path);
                            });
                          }, icon: Icon(Icons.camera_alt)),
                      IconButton(
                          onPressed: ()  async{
                            XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                            setState(() {
                              selectedimage = File(photo!.path);
                            });
                          }, icon: Icon(Icons.browse_gallery)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "productname",
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _productname,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "PRICE",
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _price,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
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
                      onChanged: (val) {
                        setState(() {
                          selected = val!;
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
                        DropdownMenuItem(child: Text("Delhi"), value: "DL"),
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
                    onPressed: () async {


                      setState(() {
                        isloading=true;
                      });
                      var name = _productname.text.toString();
                      var price= _price.text.toString();
                      var category = selected.toString();
                      var type = grp.toString();

                      if(selectedimage==null)
                        {
                          await FirebaseFirestore.instance.collection("Products")
                              .doc(widget.updateid).update({
                                  "productname":name,
                                  "price":price,
                                  "category":category,
                                  "type":type,
                          }).then((value){
                            setState(() {
                              isloading=false;
                            });
                                Navigator.of(context).pop();
                          });
                        }
                      else
                        {
                          await FirebaseStorage.instance.ref(oldimagename).delete().then((value)async{
                            var uuid = Uuid();
                            var filename = uuid.v1();
                              await FirebaseStorage.instance.ref(filename)
                                  .putFile(selectedimage!).whenComplete((){}).then((filedata) async {
                                    await filedata.ref.getDownloadURL().then((
                                        fileurl) async {
                                      await FirebaseFirestore.instance.collection("Products")
                                          .doc(widget.updateid).update({
                                        "productname":name,
                                        "price":price,
                                        "category":category,
                                        "type":type,
                                        "filename":filename,
                                        "fileurl":fileurl
                                      }).then((value){
                                        setState(() {
                                          isloading=false;
                                        });
                                        Navigator.of(context).pop();
                                      });
                                    });
                                  });
                          });
                        }

                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
