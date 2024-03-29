import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();

  // XFile? imageXFile;
  // final ImagePicker _picker = ImagePicker();

  // String sellerImageUrl = "";

  // Future<void> _getImage() async {
  //   imageXFile = await _picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     imageXFile;
  //   });
  // }

  // Future<void> formValidation() async {
  //   if (imageXFile == null) {
  //     showDialog(
  //         context: context,
  //         builder: (c) {
  //           return ErrorDialog(message: "Please select the image!");
  //         });
  //   } else {
  //     if (passwordController.text == confirmPasswordController.text) {
  //       if (confirmPasswordController.text.isNotEmpty &&
  //           emailController.text.isNotEmpty &&
  //           nameController.text.isNotEmpty) {
  //         showDialog(
  //             context: context,
  //             builder: (c) {
  //               return LoadingDialog(
  //                 message: "Registering Account ,",
  //               );
  //             });

  //         String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //         fStorage.Reference reference = fStorage.FirebaseStorage.instance
  //             .ref()
  //             .child('tables')
  //             .child(fileName);
  //         fStorage.UploadTask uploadTask =
  //             reference.putFile(File(imageXFile!.path));
  //         fStorage.TaskSnapshot taskSnapshot =
  //             await uploadTask.whenComplete(() {});
  //         await taskSnapshot.ref.getDownloadURL().then((url) {
  //           sellerImageUrl = url;
  //           // save information to firestore
  //           authenticateSellerAndSignUp();
  //         });
  //       } else {
  //         showDialog(
  //             context: context,
  //             builder: (c) {
  //               return ErrorDialog(
  //                   message: "Please enter all required information");
  //             });
  //       }
  //     } else {
  //       showDialog(
  //           context: context,
  //           builder: (c) {
  //             return ErrorDialog(
  //                 message: "The entered passwords do not match. Try again.");
  //           });
  //     }
  //   }
  // }

  // void authenticateSellerAndSignUp() async {
  //   User? currentUser;

  //   try {
  //     await firebaseAuth
  //         .createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     )
  //         .then((auth) {
  //       currentUser = auth.user;
  //     });
  //   } on FirebaseAuthException catch (error) {
  //     Navigator.pop(context);
  //     showDialog(
  //         context: context,
  //         builder: (c) {
  //           return ErrorDialog(
  //             message: error.message.toString(),
  //           );
  //         });
  //   }

  //   if (currentUser != null) {
  //     saveDataToFireStore(currentUser!).then((value) {
  //       Navigator.pop(context);
  //       //send user to homePage
  //       Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
  //       Navigator.pushReplacement(context, newRoute);
  //     });
  //   }
  // }

  // Future saveDataToFireStore(User currentUser) async {
  //   FirebaseFirestore.instance.collection("tables").doc(currentUser.uid).set({
  //     "tableUID": currentUser.uid,
  //     "tableEmail": currentUser.email,
  //     "tableName": nameController.text.trim(),
  //     "tableAvatarUrl": sellerImageUrl,
  //     "status": "approve",
  //   });
  //   // save data locally
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences!.setString('uid', currentUser.uid);
  //   await sharedPreferences!.setString('email', currentUser.email.toString());
  //   await sharedPreferences!.setString('name', nameController.text.trim());
  //   await sharedPreferences!.setString('photoUrl', sellerImageUrl);
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: const [
          SizedBox(
            height: 100,
          ),
          Text(
            'Vui lòng liên hệ với chủ nhà hàng!!!',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    )
        // child: Container(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       InkWell(
        //         onTap: () {
        //           _getImage();
        //         },
        //         child: CircleAvatar(
        //           radius: MediaQuery.of(context).size.width * 0.20,
        //           backgroundColor: Colors.white,
        //           backgroundImage: imageXFile == null
        //               ? null
        //               : FileImage(File(imageXFile!.path)),
        //           child: imageXFile == null
        //               ? Icon(
        //                   Icons.add_photo_alternate,
        //                   size: MediaQuery.of(context).size.width * 0.20,
        //                   color: Colors.grey,
        //                 )
        //               : null,
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Form(
        //         key: _formKey,
        //         child: Column(
        //           children: [
        //             CustomTextField(
        //               data: Icons.person,
        //               controller: nameController,
        //               hintText: "Name",
        //               isObsecre: false,
        //             ),
        //             CustomTextField(
        //               data: Icons.email,
        //               controller: emailController,
        //               hintText: "Email",
        //               isObsecre: false,
        //             ),
        //             CustomTextField(
        //               data: Icons.lock,
        //               controller: passwordController,
        //               hintText: "Password",
        //               isObsecre: true,
        //             ),
        //             CustomTextField(
        //               data: Icons.lock,
        //               controller: confirmPasswordController,
        //               hintText: "Confirm Password",
        //               isObsecre: true,
        //             ),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 30,
        //       ),
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           primary: Colors.blueAccent,
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        //         ),
        //         onPressed: () {
        //           formValidation();
        //         },
        //         child: const Text(
        //           "Register",
        //           style:
        //               TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 30,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
