import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecommerce/Wiget/button.dart';
import 'package:myecommerce/Wiget/my_textfield.dart';
import 'package:myecommerce/model/user.dart';
import 'package:myecommerce/provider/provider.dart';
import 'package:myecommerce/screen/home_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static Pattern patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  TextEditingController name;
  TextEditingController email;
  TextEditingController password;
  TextEditingController phone;
  bool edit = false;
  var uid;
  var imageMap;
  RegExp regex = RegExp(ProfilePage.pattern);
  RegExp regExp = RegExp(ProfilePage.patttern);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void userinputData() async {
    User user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
  }

  Widget filledContainer({@required String name}) {
    return Container(
      height: 62,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Future getCameraImage(ImageSource choise) async {
    final pickedFile = await ImagePicker().getImage(source: choise);
    setState(() {
      _image = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> alart(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose an action"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      getCameraImage(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      getCameraImage(ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<String> uploadFile(File _image) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/$uid');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot task = await uploadTask.onComplete;
    final String _imageUrl = await task.ref.getDownloadURL();
    return _imageUrl;
  }

  void userDataUpdate({UserData currenUsers}) async {
    _image != null ? imageMap = await uploadFile(_image) : Container();
    await FirebaseFirestore.instance.collection("user").doc(uid).update({
      "FullName": name.text,
      "Email": email.text,
      "password": password.text,
      "PhoneNumber": phone.text,
      "imageUrl": _image == null ? currenUsers.image : imageMap,
    });
  }

  showSnackBar({UserData currentUser}) {
    if (name.text.isEmpty && email.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('All field is emtpy'),
          backgroundColor: Color(0xffe4a344),
        ),
      );
      return;
    }
    if (name.text.trim().isEmpty || name.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Full Name is empty',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Color(0xffe4a344),
        ),
      );
      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Email is empty'),
          backgroundColor: Color(0xffe4a344),
        ),
      );
      return;
    } else if (!regex.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please Enter Valid Email'),
          backgroundColor: Color(0xffe4a344),
        ),
      );
      return;
    } else {
      setState(() {
        edit = false;
        userDataUpdate(currenUsers: currentUser);
        uploadFile(_image);
      });
    }
  }

  @override
  void initState() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    provider.fetchUserData();
    UserData currentUser = provider.getCurrrentUser;
    name = TextEditingController(text: currentUser.fullname);
    email = TextEditingController(text: currentUser.email);
    phone = TextEditingController(text: currentUser.phone);
    password = TextEditingController(text: currentUser.password);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.fetchUserData();
    UserData currentUser = provider.getCurrrentUser;
    userinputData();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () {
              setState(() {
                edit = true;
              });
            },
          ),
        ],
        leading: edit == false
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  setState(
                    () {
                      edit = false;
                    },
                  );
                },
              ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 74,
                        backgroundColor: Colors.black54,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: _image == null
                              ? currentUser.image == null
                                  ? AssetImage('images/profile.jpg')
                                  : NetworkImage(currentUser.image)
                              : FileImage(_image),
                        ),
                      ),
                      edit
                          ? Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.white),
                                  onPressed: () {
                                    alart(context);
                                  },
                                ),
                              ),
                            )
                          : Text("")
                    ],
                  ),
                  Text(
                    currentUser.fullname,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    currentUser.email,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            edit
                ? Container(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MYTextField(
                          controller: name,
                          eyeicon: null,
                          hintText: "User Name",
                          keyboard: TextInputType.name,
                          obscuretext: false,
                        ),
                        MYTextField(
                          controller: email,
                          eyeicon: null,
                          hintText: "Email",
                          keyboard: TextInputType.name,
                          obscuretext: false,
                        ),
                        MYTextField(
                          controller: password,
                          eyeicon: null,
                          hintText: "Password",
                          keyboard: TextInputType.name,
                          obscuretext: false,
                        ),
                        MYTextField(
                          controller: phone,
                          eyeicon: null,
                          hintText: "Phone Number",
                          keyboard: TextInputType.name,
                          obscuretext: false,
                        ),
                        Button(
                          buttoncolors: Theme.of(context).textSelectionColor,
                          textcolor: Colors.black,
                          tittle: "Update",
                          whenpress: () {
                            userDataUpdate(currenUsers: currentUser);
                            edit = false;
                            // showSnackBar(
                            //   currentUser: currentUser,
                            // );
                          },
                        )
                      ],
                    ),
                  )
                : Container(
                    height: 370,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        filledContainer(
                          name: currentUser.fullname,
                        ),
                        filledContainer(
                          name: currentUser.email,
                        ),
                        filledContainer(
                          name: currentUser.password,
                        ),
                        filledContainer(
                          name: currentUser.phone,
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
