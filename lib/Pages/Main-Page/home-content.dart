import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nittiv_new_version/Provider/comment-provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/Utils/convert-datetime-epoch.dart';
import '../../Core/Utils/nittiv-color.dart';
import '../../Models/UserModel.dart';
import '../Comment-Page/display-comments.dart';
import '../Post-Page/create-post.dart';
import '../Post-Page/post-header.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: CreatePostSection(),
            ),
          ),
          ButtonAddRow(),
          SizedBox(
            height: 20,
          ),
          PostHeader(),
        ],
      ),
    );
  }
}

class ButtonAddRow extends StatelessWidget {
  const ButtonAddRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 570,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xffD0D0D0)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo,
                      color: NittivColors.base.shade600,
                    ),
                    Center(
                        child: Text(
                      ' Add Photo/Video',
                      style: TextStyle(color: NittivColors.base.shade600),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_location_alt_outlined,
                      color: NittivColors.base.shade600,
                    ),
                    Center(
                        child: Text(
                      ' Add Location',
                      style: TextStyle(color: NittivColors.base.shade600),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_alt_outlined,
                      color: NittivColors.base.shade600,
                    ),
                    Center(
                        child: Text(
                      ' Tag People',
                      style: TextStyle(color: NittivColors.base.shade600),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostActions extends StatefulWidget {
  final int index;
  final DocumentSnapshot post;

  const PostActions({Key? key, required this.index, required this.post})
      : super(key: key);

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  bool isVisible = false;

  User? user = FirebaseAuth.instance.currentUser;

  UserModel? loggedInUser = UserModel();

   ValueNotifier<bool> updateColor = ValueNotifier(false);





  loggedInUserInfo() async {
    final res = await FirebaseFirestore.instance
        .collection("table-user")
        .where('email', isEqualTo: user!.email)
        .get();

    for (var doc in res.docs) {
      loggedInUser = UserModel.fromMap(doc.data());
    }
  }

  @override
  void initState() {
    loggedInUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CommentProvider>().showOnlyPostTextFieldComment();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tooltip(
              message: "Favourite",
              child: ButtonCommentLikeShare(
                  text: "",
                  icon: IconFavourite(uid: widget.post.id),
                  ontap: () async {
                    await FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                      DocumentReference postRef = FirebaseFirestore.instance
                          .collection('table-like')
                          .doc(widget.post.id)
                          .collection(widget.post.id)
                          .doc(widget.post.id);

                      DocumentSnapshot snapshot =
                          await transaction.get(postRef);


                      int likeCount = snapshot.get("likeCount");
                      bool emailSaNagLike = snapshot.get("emailSaNagLike").contains(loggedInUser!.email);
                      bool like = snapshot.get("like");
                      String firstName = snapshot.get("firstName");

                      if(emailSaNagLike == true && like == true){

                        //This condition is for unlike

                        transaction
                            .update(postRef, { "likeCount": likeCount - 1,
                          "firstName": firstName,
                          'emailSaNagLike':
                        FieldValue.arrayRemove(
                          [user!.email],
                        )});
                      }else{
                        transaction
                            .update(postRef, { "likeCount": likeCount + 1,
                              "like": true,
                          "emailSaNagLike":
                                   FieldValue.arrayUnion([loggedInUser!.email],),
                          "firstName": loggedInUser!.firstName,
                        });
                      }


                      // await FirebaseFirestore.instance
                      //     .collection('table-like')
                      //     .doc(widget.post.id)
                      //     .collection(widget.post.id)
                      //     .doc(widget.post.id)
                      //     .update(
                      //   {
                      //
                      //     "emailSaNagLike":
                      //         FieldValue.arrayUnion([loggedInUser!.email]),
                      //     "firstName": loggedInUser!.firstName,
                      //   },
                      // ).whenComplete(() async {
                      //
                      //
                      // });

                      //
                      // transaction
                      //     .set(postRef,
                      //
                      //     {
                      //       "postId": widget.post.id,
                      //       "like": true,
                      //       'commentCount': 1,
                      //       "emailSaNagLike": loggedInUser!.email,
                      //       "userName": loggedInUser!.firstName,
                      //
                      //     },
                      // );
                    });
                  }),
            ),

            // InkWell(
            //   onTap: (){
            //
            //   },
            //   child: Icon(
            //     Icons.favorite,
            //     color: NittivColors.base.shade600,
            //   ),
            // ),

            SizedBox(
              width: 30,
            ),

            InkWell(
              onTap: () {

                updateColor.value = !updateColor.value;

                // isVisible = !isVisible;
                //
                //  (context as Element).markNeedsBuild();
              },
              child: Icon(
                Icons.comment,
                color: NittivColors.base.shade600,
              ),
            ),
            // Tooltip(
            //   message: "Comment",
            //   child: ButtonCommentLikeShare(
            //       text: "",
            //       icon: Icon(
            //         Icons.comment,
            //         color: NittivColors.base.shade600,
            //       ),
            //       ontap: () async {
            //
            //
            //         // await context.read<CommentProvider>().setShowTextFieldComment(widget.index,isVisible);
            //         // context.read<CommentProvider>().setVisible(isVisible);
            //         //
            //         // isVisible = !isVisible;
            //         //
            //         //
            //
            //         setState(() {
            //           isVisible = !isVisible;
            //         });
            //
            //         // (context as Element).markNeedsBuild();
            //
            //        // Provider.of<CommentProvider>(context,listen: false).setVisibleCommentTextField(isVisible);
            //       }),
            // ),
            SizedBox(
              width: 30,
            ),
            Tooltip(
              message: "Share",
              child: ButtonCommentLikeShare(
                text: "",
                icon: Icon(
                  Icons.share,
                  color: NittivColors.base.shade600,
                ),
                ontap: () {},
              ),
            ),
            Spacer(),
            Text(
              "Travel here  ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            InkWell(
                onTap: () {},
                splashColor: Colors.grey[300],
                child: Icon(Icons.travel_explore)),
          ],
        ),
        const SizedBox(
          height: 8,
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Row(
        //       children: [
        //         CachedNetworkImage(
        //           imageUrl:
        //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrUi1PZFqkzQ63f-VnwWvRA2VWzXYCEdiZi3oIDUlm&s",
        //           imageBuilder: (context, imageProvider) => Container(
        //             width: 16.0,
        //             height: 16.0,
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               image: DecorationImage(
        //                   image: imageProvider, fit: BoxFit.cover),
        //             ),
        //           ),
        //           placeholder: (context, url) =>
        //               const CircularProgressIndicator(
        //             strokeWidth: 1,
        //           ),
        //           errorWidget: (context, url, error) => const Icon(Icons.error),
        //         ),
        //         RichText(
        //           text: TextSpan(
        //               text: "  Like by ",
        //               style: const TextStyle(color: Colors.black, fontSize: 12),
        //               children: [
        //                 TextSpan(
        //                   text: "You",
        //                   style: const TextStyle(
        //                       color: Colors.black, fontWeight: FontWeight.bold),
        //                 ),
        //                 TextSpan(
        //                   text: " and ",
        //                   style: const TextStyle(
        //                     color: Colors.black,
        //                   ),
        //                 ),
        //                 TextSpan(
        //                   text: " others",
        //                   style: const TextStyle(
        //                     color: Colors.black,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 )
        //               ]),
        //         ),
        //       ],
        //     ),
        //     Text(
        //       "View all 143 cooments",
        //       style: TextStyle(color: Colors.grey[500], fontSize: 10),
        //     ),
        //     Text(" a wekk ago",
        //         style: TextStyle(color: Colors.grey[500], fontSize: 10)),
        //   ],
        // ),

        LikeBy(post: widget.post, index: widget.index),
        Divider(
          thickness: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 4),
        // Consumer<CommentProvider>(
        //     builder: (context, state,_) {
        //       if(state.getVisible){
        //         if(state.getShowTextFieldComment(widget.index)){
        //           return DisplayComments(post: widget.post, index: widget.index);
        //         }
        //       }
        //
        //      return const SizedBox();
        //     }
        // ),
        ValueListenableBuilder<bool>(
            valueListenable: updateColor,
            builder: (context, val, child) {

              return  updateColor.value == true ?
               DisplayComments(post: widget.post,index: widget.index) : Text("");
            }),


        // Visibility(
        //   visible: isVisible,
        //   child: DisplayComments(
        //     post: widget.post,
        //     index: widget.index,
        //   ),
        // ),
      ],
    );
  }
}

class LikeBy extends StatefulWidget {
  const LikeBy({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  final DocumentSnapshot post;
  final int index;

  @override
  State<LikeBy> createState() => _LikeByState();
}

class _LikeByState extends State<LikeBy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(" Build Like By");

    User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('table-like')
            .doc(widget.post.id)
            .collection(widget.post.id)
            .snapshots(),
        // .collection("table-like")
        // .where("postId", isEqualTo: post.get('id'))
        // .where("like", isEqualTo: true)
        // .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('');
          }

          if (!snapshot.hasData) {
            return const Text('');
          }

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            String userName = snapshot.data!.docs[i].get('firstName');
            int countLikes = snapshot.data!.docs[i].get('likeCount');




              return Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: countLikes == 0 ? "" : "  Like by ",
                        style: const TextStyle(
                            color: Colors.black, fontSize: 12),
                        children: [
                          TextSpan(
                            text:  countLikes == 0 ? "" : snapshot.data!.docs[i]
                                .get("emailSaNagLike")
                                .contains(user!.email) ? "You" : userName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:  countLikes == 0 ? "" : countLikes == 1 ? "": " and ",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:  countLikes == 0 ? "" :  countLikes == 1 ? "" : "$countLikes" " others",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                  ),

                  Text(
                    "View all "
                        "${snapshot.data!.docs[i]
                        .get('commentCount')
                        .toString()}  comments",
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  // Text(
                  //     readTimestamp(
                  //       post.get('createdAt').millisecondsSinceEpoch,
                  //     ),
                  //     style: TextStyle(color: Colors.grey[500], fontSize: 10)),
                ],
              );
            }



          return Text("No Comment Yet...");
          //return Text("${ context.watch<CommentProvider>().getCountComments}");
          // for (int i = 0; i < snapshot.data!.docs.length; i++) {
          //   if (snapshot.data!.docs[i].get('postId') == post.get('id')) {
          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(
          //           children: [
          //             CachedNetworkImage(
          //               imageUrl:
          //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrUi1PZFqkzQ63f-VnwWvRA2VWzXYCEdiZi3oIDUlm&s",
          //               imageBuilder: (context, imageProvider) => Container(
          //                 width: 16.0,
          //                 height: 16.0,
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   image: DecorationImage(
          //                       image: imageProvider, fit: BoxFit.cover),
          //                 ),
          //               ),
          //               placeholder: (context, url) =>
          //                   const CircularProgressIndicator(
          //                 strokeWidth: 1,
          //               ),
          //               errorWidget: (context, url, error) =>
          //                   const Icon(Icons.error),
          //             ),
          //             RichText(
          //               text: TextSpan(
          //                   text: "  Like by ",
          //                   style: const TextStyle(
          //                       color: Colors.black, fontSize: 12),
          //                   children: [
          //                     TextSpan(
          //                       text: snapshot.data!.docs[i]
          //                                   .get('emailSaNagLike') ==
          //                               user!.email
          //                           ? "You"
          //                           : snapshot.data!.docs[i].get('userName'),
          //                       style: const TextStyle(
          //                           color: Colors.black,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                     TextSpan(
          //                       text: countLikes == 0 ? "" : " and ",
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                       ),
          //                     ),
          //                     TextSpan(
          //                       text: countLikes == 0
          //                           ? ""
          //                           : "$countLikes  others",
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     )
          //                   ]),
          //             ),
          //           ],
          //         ),
          //         Text(
          //           "View all "
          //           "${snapshot.data!.docs[i].get('commentCount')}"
          //           " comments",
          //           style: TextStyle(color: Colors.grey[500], fontSize: 10),
          //         ),
          //         Text(
          //             readTimestamp(
          //               post.get('createdAt').millisecondsSinceEpoch,
          //             ),
          //             style: TextStyle(color: Colors.grey[500], fontSize: 10)),
          //       ],
          //     );
          //   }
          // }

          // return Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       children: [
          //         CachedNetworkImage(
          //           imageUrl:
          //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrUi1PZFqkzQ63f-VnwWvRA2VWzXYCEdiZi3oIDUlm&s",
          //           imageBuilder: (context, imageProvider) => Container(
          //             width: 16.0,
          //             height: 16.0,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               image: DecorationImage(
          //                   image: imageProvider, fit: BoxFit.cover),
          //             ),
          //           ),
          //           placeholder: (context, url) =>
          //               const CircularProgressIndicator(
          //             strokeWidth: 1,
          //           ),
          //           errorWidget: (context, url, error) =>
          //               const Icon(Icons.error),
          //         ),
          //         RichText(
          //           text: const TextSpan(
          //               text: "  Click like if you want",
          //               style: TextStyle(color: Colors.black, fontSize: 12),
          //               children: []),
          //         ),
          //       ],
          //     ),
          //   ],
          // );
        });
  }
}

class IconFavourite extends StatefulWidget {
  final String uid;

  const IconFavourite({
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  State<IconFavourite> createState() => _IconFavouriteState();
}

class _IconFavouriteState extends State<IconFavourite> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            //.collection("table-like")
            //.where("emailSaNagLike", isEqualTo: user!.email)
            .collection('table-like')
            .doc(widget.uid)
            .collection(widget.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (!snapshot.hasData) {
            return const Icon(
              Icons.favorite_outline,
            );
          }

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            if (snapshot.data!.docs[i]
                    .get('emailSaNagLike')
                    .contains(user!.email) &&
                snapshot.data!.docs[i].get('postId') == widget.uid &&
                snapshot.data!.docs[i].get('like') == true) {
              return const Icon(
                Icons.favorite,
                color: Colors.red,
              );
            }
          }

          return Icon(
            Icons.favorite,
            color: NittivColors.base.shade600,
          );
        });
  }
}

class ButtonCommentLikeShare extends StatelessWidget {
  final String text;

  final Function() ontap;
  final Widget icon;

  const ButtonCommentLikeShare({
    required this.text,
    required this.icon,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      focusColor: Colors.transparent,
      hoverColor: Colors.grey[400],
      highlightColor: Colors.transparent,
      onTap: ontap,
      child: Row(
        children: [
          Text(text),
          icon,
        ],
      ),
    );
  }
}
