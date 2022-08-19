// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signapp/login_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sign in google',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sign in google Abk App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    Column buidInfo() {
      return Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(controller
                    .zgoogleAccount.value?.photoUrl ??
                'https://img-19.commentcamarche.net/cI8qqj-finfDcmx6jMK6Vr-krEw=/1500x/smart/b829396acc244fd484c5ddcdcb2b08f3/ccmcms-commentcamarche/20494859.jpg'),
            radius: 80,
            backgroundColor: Colors.white,
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            controller.zgoogleAccount.value?.displayName ?? '',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            controller.zgoogleAccount.value?.email ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              controller.googleLogout();
            },
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: const Text("Sign out with Google"),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              if (controller.zgoogleAccount.value == null) {
                return buidSignIn();
              } else
                return buidInfo();
            }),
            MaterialButton(
              onPressed: () {
                controller.googleLogout();
              },
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: const Text("Sign out with Google"),
            ),
          ],
        ),
      ),
    );
  }

  Column buidSignIn() {
    return Column(
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            controller.googleLogin();
          },
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          icon: Icon(Icons.login),
          label: const Text("Sign in with Google"),
        ),
      ],
    );
  }
}
