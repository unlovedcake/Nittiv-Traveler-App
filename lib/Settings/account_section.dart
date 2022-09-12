import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/auth-provider.dart';
import 'settings_button.dart';


class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

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
                Icons.account_box_rounded,
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
                      'Account',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text('Edit and Manage your account details',
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffD0D0D0)))),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              title: const Text('User', style: TextStyle(fontSize: 12)),
              subtitle: const Text('Traveler', style: TextStyle(fontSize: 10)),
              onTap: () {},
              trailing: const Icon(Icons.chevron_right),
              leading: const Icon(
                Icons.circle,
                size: 45,
              ),
            ),
          ),
          SettingsButton(
            placeholder: 'Switch to Influencer',
            function: () {},
            borderBottom: true,
          ),
          SettingsButton(
            placeholder: 'Logout',
            function: () {

              AuthProvider.logout(context);

            },
            borderBottom: false,
          ),
        ]),
      ),
    ]);
  }
}
