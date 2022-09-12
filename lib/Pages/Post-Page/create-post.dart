import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nittiv_new_version/Pages/Post-Page/showDialogPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/UserModel.dart';

class CreatePostSection extends StatefulWidget {
  const CreatePostSection({super.key});

  @override
  State<CreatePostSection> createState() => _CreatePostSectionState();
}

class _CreatePostSectionState extends State<CreatePostSection> {
  String? _email;

  User? user;
  SharedPreferences? prefs;

  UserModel? loggedInUser = UserModel();

  List<UserModel> listUsers = [];

  CollectionReference users = FirebaseFirestore.instance.collection('table-user');




  loggedIn() async {
    await FirebaseFirestore.instance
        .collection("table-user")   
        .where('email', isEqualTo: _email)
        .get()
        .then((value) {

     loggedInUser?.firstName = value.docs.first['firstName'];
      loggedInUser?.imageUrl = value.docs.first['imageUrl'];
      loggedInUser?.email = value.docs.first['email'];
      setState(() {});
    });
  }




  @override
  void initState() {

    super.initState();

    getEmail();
  }


  getEmail() async {
    SharedPreferences? prefs;

    prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email')!;

    loggedIn();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;

    // if(user == null){
    //   return Text("");
    // }
    //
    // return FutureBuilder<DocumentSnapshot>(
    //   future: users.doc(user!.uid).get(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //
    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }
    //
    //     if (snapshot.hasData && !snapshot.data!.exists) {
    //       return Text("Document does not exist");
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    //       return Text("Full Name: ${data['firstName']} ${data['email']}");
    //     }
    //
    //     return Text("");
    //   },
    // );

    return Container(
      height: 120,
      child:  Column(
    children: [
    SizedBox(
    width: 570,
      child: DecoratedBox(
          decoration: const BoxDecoration(),
          child: Column(children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 5),
              onTap: () {},
              title: Container(
                margin: const EdgeInsets.only(
                    top: 14, bottom: 22),
                child: InkWell(
                  hoverColor: Colors.white,
                  onTap: () {
                    ShowDialogPost.displayDialogPost(
                        loggedInUser?.firstName,
                        loggedInUser?.imageUrl,
                        loggedInUser!.email.toString(),
                        context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${"What's on your mind   ${loggedInUser?.firstName ?? ""}"} ?"),
                      ],
                    ),
                  ),
                ),
              ),
              leading: CachedNetworkImage(
                imageUrl:loggedInUser?.imageUrl ?? "",
                imageBuilder: (context, imageProvider) =>
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover),
                      ),
                    ),
                placeholder: (context, url) =>
                const CircularProgressIndicator(
                  strokeWidth: 1,
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),
          ])),
    ),
    ],
    ),
    );
  }
}
