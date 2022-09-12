import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/Utils/mobile-desktop-view.dart';
import '../../Provider/auth-provider.dart';
import '../../Settings/account_section.dart';
import '../../Settings/support_section.dart';
import 'Inbox-Page/inbox-content.dart';
import 'Profile-Page/profile-content.dart';
import 'Update-Page/update-content.dart';
import 'home-content.dart';
import 'nittiv-navbar.dart';

class NittivHome extends StatefulWidget {
  // final Widget selectedTab;
  //final int currentIndex;
  const NittivHome({
    Key? key,
    // required this.selectedTab,
    //required this.currentIndex,
  }) : super(key: key);

  @override
  State<NittivHome> createState() => _NittivHomeState();
}

class _NittivHomeState extends State<NittivHome> {
  final List<BottomNavbarConfigs> configs = const [
    BottomNavbarConfigs(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      routeName: 'home',
    ),
    BottomNavbarConfigs(
      icon: Icon(Icons.person_outline),
      label: 'Profile',
      routeName: 'profile',
    ),
    BottomNavbarConfigs(
      icon: Icon(Icons.message_outlined),
      label: 'Inbox',
      routeName: 'inbox',
    ),
    BottomNavbarConfigs(
      icon: Icon(Icons.notifications_outlined),
      label: 'Updates',
      routeName: 'updates',
    ),
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    print("Rebuild");
    final size = MediaQuery.of(context).size;

    int indexNavbar = context.watch<AuthProvider>().getNabvarIndex;

    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: TextButton(
          onPressed: () {

          },
          child: Image.asset(
            'icons/nittiv-logo-landscape-sm.png',
            color: Theme.of(context).primaryColor,
          ),
        ),
        leadingWidth: 120,
        title: View.isDesktop(size.width)
            ? Center(
          child: SizedBox(
            width: 300,
            child: NittivNavbar(
              configs: configs,
              currentIndex: indexNavbar,
              // currentIndex: widget.currentIndex,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
        )
            : null,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: NittivSearchDelegate());
            },
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: (){ scaffoldKey.currentState?.openEndDrawer();},
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: !View.isDesktop(size.width)
          ? NittivNavbar(
        configs: configs,
        currentIndex: indexNavbar,
      )
          : null,
       body: indexNavbar == 1 ? ProfileContent() : indexNavbar == 2 ? const InboxContent()
           : indexNavbar == 3 ? const UpdateContent() : const HomeContent(),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
                height: 65,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Settings',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                            onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.close))
                      ]),
                )),
             const AccountSection(),
             const SupportSection(),
          ],
        ),
      ),
    );
  }
}

class NittivSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
}
