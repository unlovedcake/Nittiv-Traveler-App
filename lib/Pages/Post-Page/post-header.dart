import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nittiv_new_version/Core/Utils/post-stream.dart';
import 'package:nittiv_new_version/Pages/Post-Page/post-content.dart';
import 'package:provider/provider.dart';

import '../../Provider/comment-provider.dart';

class PostHeader extends StatefulWidget {
  const PostHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  @override
  Widget build(BuildContext context) {
    const PostStream stream = PostStream("table-post", true, "createdAt");


    return SizedBox(
      width: 600,
      child: StreamBuilder(
          stream: stream.createStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Check your internet access."),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text("Loading...."),
              );
            }
            return PostContent(postDocs: snapshot.data!.docs);
          }),
    );
  }
}
