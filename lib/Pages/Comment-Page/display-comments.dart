import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nittiv_new_version/Pages/Comment-Page/showtext-comment-field.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../../Core/Utils/convert-datetime-epoch.dart';
import '../../Core/Utils/mobile-desktop-view.dart';
import '../../Provider/comment-provider.dart';
import 'comments-list.dart';

class DisplayComments extends StatefulWidget {
  final DocumentSnapshot post;
  final int index;

  const DisplayComments({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  @override
  State<DisplayComments> createState() => _DisplayCommentsState();
}

class _DisplayCommentsState extends State<DisplayComments> {
  int _limit = 8;
  final int _limitIncrement = 5;
  final ScrollController scrollController = ScrollController();

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _limit += _limitIncrement;
      context.read<CommentProvider>().setCountComment(_limit);

      //Provider.of<CommentProvider>(context,listen: false).setCountComment(_limit);

      print("OKES");
    }
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    int limit =
        Provider.of<CommentProvider>(context, listen: false).getCountComments;

    // return ShowListAllComments(widget: widget);

    return StreamBuilder<QuerySnapshot>(

        stream: context.read<CommentProvider>().displayComments(widget.post.id),
        // stream: FirebaseFirestore.instance
        //     .collection('table-comments')
        //     .doc(widget.post.id)
        //     .collection(widget.post.id)
        //     //.limit( Provider.of<CommentProvider>(context,listen: true).getCountComments)
        //     .orderBy("createdAt", descending: true)
        //     .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          } else if (snapshot.hasError) {
            return Text("Something went wrong.");
          } else if (snapshot.data!.docs.isEmpty) {
            return Column(
              children: [
                //context
                // .watch<CommentProvider>()
                //     .getShowTextFieldComment(widget.index) ?
                ShowTextCommentField(
                    post: widget.post, index: snapshot.data!.docs.length),
                const Text(
                  "No Comment Yet...",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            final Size size = MediaQuery.of(context).size;
            return Column(
              children: [
                //
                // context.watch<CommentProvider>()
                //     .getShowTextFieldComment(widget.index) ?
                ShowTextCommentField(
                    post: widget.post, index: snapshot.data!.docs.length),

                // ConstrainedBox(
                //   constraints: const BoxConstraints(maxHeight: 200),
                //   child: ListView.builder(
                //       controller: scrollController,
                //       //shrinkWrap: true,
                //       itemCount: snapshot.data!.docs.length,
                //       itemBuilder: (context, index) {
                //         final DocumentSnapshot comment =
                //             snapshot.data!.docs[index];
                //         return Padding(
                //           padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                //           child: Wrap(
                //             direction: Axis.vertical,
                //             children: [
                //               Wrap(
                //                 crossAxisAlignment: WrapCrossAlignment.center,
                //                 runAlignment: WrapAlignment.center,
                //                 alignment: WrapAlignment.center,
                //                 runSpacing: 10,
                //                 children: [
                //                   CachedNetworkImage(
                //                     imageUrl:
                //                         comment['user']['userCommentImage'] ?? "",
                //                     imageBuilder: (context, imageProvider) =>
                //                         Container(
                //                       width: 30.0,
                //                       height: 30.0,
                //                       decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         image: DecorationImage(
                //                             image: imageProvider,
                //                             fit: BoxFit.cover),
                //                       ),
                //                     ),
                //                     placeholder: (context, url) =>
                //                         const CircularProgressIndicator(
                //                       strokeWidth: 1,
                //                     ),
                //                     errorWidget: (context, url, error) =>
                //                         const Icon(Icons.error),
                //                   ),
                //                   Text(
                //                     '   ${comment['user']['userCommentName'] ?? ""}  ',
                //                     style: TextStyle(fontWeight: FontWeight.bold),
                //                   ),
                //                   Text(
                //                     readTimestamp(comment['createdAt']
                //                             .millisecondsSinceEpoch ??
                //                         143),
                //                     style: TextStyle(fontSize: 8),
                //                   ),
                //                 ],
                //               ),
                //               Container(
                //                 padding: EdgeInsets.only(left: 40),
                //                 width: View.isMobile(size.width) ? 440 : 550,
                //                 child: Text(comment['comment'] ?? ""),
                //               ),
                //             ],
                //           ),
                //         );
                //       }),
                // ),
              //  ConstrainedBox(  constraints: const BoxConstraints(maxHeight: 300),child: ShowListAllComments(widget: widget)),

                ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: CommentsList(
                      scrollController: scrollController,
                      commentsDoc: snapshot.data!.docs,
                    ))
              ],
            );
          } else {
            return Text("No Commet Yet.");
          }
        });
  }
}

class ShowListAllComments extends StatelessWidget {
  const ShowListAllComments({
    Key? key,
    required this.widget,

  }) : super(key: key);

  final DisplayComments widget;


  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      // Use SliverAppBar in header to make it sticky
      shrinkWrap: true,
      header: const SliverToBoxAdapter(child: Text('Last Comment',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
      footer: const SliverToBoxAdapter(child: Text('First Comment',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
      // item builder type is compulsory.
      itemBuilderType: PaginateBuilderType.listView,
      //Change types accordingly
      itemBuilder: (context, documentSnapshots, index) {
        final data = documentSnapshots[index].data() as Map?;

        return Padding(
          padding:  EdgeInsets.only(left: 8.0,top: 8.0),
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
                    imageUrl:data!['user']['userCommentImage'] ?? "",
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
                    '   ${data['user']['userCommentName'] ?? ""}  ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    readTimestamp(
                        data['createdAt'].millisecondsSinceEpoch ??
                            143),
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 40),
                width: View.isMobile(200) ? 440 : 550,
                child:   Text(data['comment'] ?? ""),
              ),


            ],
          ),
        );

      },
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance
          .collection('table-comments')
          .doc(widget.post.id)
          .collection(widget.post.id)
          .orderBy("createdAt", descending: true),
      itemsPerPage: 4,
      // to fetch real-time data
      isLive: true,
    );
  }
}
