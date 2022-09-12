import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Core/Utils/convert-datetime-epoch.dart';
import '../Main-Page/home-content.dart';



class PostContent extends StatelessWidget {
  final List<QueryDocumentSnapshot> postDocs;

  const PostContent({
    Key? key,
    required this.postDocs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
          children: List<Widget>.generate(
        postDocs.length,
        (index) {
          final DocumentSnapshot post = postDocs[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle),
                    // child: Image.network(post['user']['userImage']
                    child: CachedNetworkImage(
                      imageUrl: post['user']['userImage'] ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: post['user']['userName'],
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: [
                            const TextSpan(
                              text: 'is at ',
                            ),
                            const TextSpan(
                              text: "Cebu   ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: readTimestamp(
                                  post['createdAt'].millisecondsSinceEpoch),
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                child: Text(post['body']),
              ),
              const SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: post['imagePost'],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    PostActions(index: index, post: post),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          );
        },
      )),
    );
  }
}
