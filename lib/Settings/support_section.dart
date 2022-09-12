import 'package:flutter/material.dart';

import '../Settings/settings_button.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.mail_outline_rounded,
                size: 40,
                color: Color(0xff008575),
              ),
            ),
            Title(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Help and Feedback',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text('Reach us with your feedback and inquiries',
                        style: TextStyle(fontSize: 10))
                  ],
                ))
          ],
        ),
      )),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(children: [
          SettingsButton(
            placeholder: 'Support',
            function: () {},
            borderBottom: true,
          ),
          SettingsButton(
            placeholder: 'About',
            function: () {},
            borderBottom: true,
          ),
          SettingsButton(
            placeholder: 'Privacy Policy',
            function: () {},
            borderBottom: true,
          ),
          SettingsButton(
            placeholder: 'Terms of Service',
            function: () {},
            borderBottom: false,
          ),
        ]),
      ),
    ]);
  }
}
