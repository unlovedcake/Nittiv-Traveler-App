import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/nittiv-color.dart';
import '../Utils/social-link.dart';

class NittivFooter extends StatelessWidget {
  const NittivFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/nittiv-logo-landscape.png',
            height: 64,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: socialLinks
                .map<Widget>(
                  (socialLink) => Tooltip(
                    message: socialLink.name,
                    child: TextButton(
                      onPressed: () async {
                        if (await canLaunch(socialLink.url)) {
                          await launch(socialLink.url);
                        } else {
                          throw 'Could not launch $socialLink.url';
                        }
                      },
                      child: Image.asset(
                        socialLink.assetImagePath,
                        height: 24,
                        color: NittivColors.base.shade100,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
