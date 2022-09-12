import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Core/Utils/convert-datetime-epoch.dart';
import '../../Core/Utils/mobile-desktop-view.dart';

class CommentsList extends StatefulWidget {
  final List<QueryDocumentSnapshot> commentsDoc;
  final ScrollController scrollController;
  const CommentsList({
    Key? key,
    required this.commentsDoc,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
        controller: widget.scrollController,
        shrinkWrap: true,
        itemCount: widget.commentsDoc.length,

        itemBuilder: (context, index) {
          final DocumentSnapshot comment = widget.commentsDoc[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 8.0),
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  children: [

                    CachedNetworkImage(
                      imageUrl: comment['user']['userCommentImage'] ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 1,),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),

                    Text(
                      '   ${comment['user']['userCommentName'] ?? ""}  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      readTimestamp(
                          comment['createdAt'].millisecondsSinceEpoch ??
                              143),
                      style: TextStyle(fontSize: 8),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 40),
                  width: View.isMobile(size.width) ? 440 : 550,
                  child:   Text(comment['comment'] ?? ""),
                ),


              ],
            ),
          );
        });
  }
}
