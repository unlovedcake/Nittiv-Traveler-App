
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Core/Router/routesname.dart';
import '../../Provider/auth-provider.dart';

class NittivNavbar extends StatefulWidget {
  final List<BottomNavbarConfigs> configs;
  final int currentIndex;
  final double? elevation;
  final Color? backgroundColor;

  const NittivNavbar({
    Key? key,
    required this.configs,
    required this.currentIndex,
    this.elevation,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<NittivNavbar> createState() => _NittivNavbarState();
}

class _NittivNavbarState extends State<NittivNavbar> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColor,
      items: widget.configs
          .map(
            (navbarConfig) => BottomNavigationBarItem(
          icon: navbarConfig.icon,
          label: navbarConfig.label,
          tooltip: navbarConfig.label,
        ),
      )
          .toList(),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });

        if(currentIndex == 0){

          context.read<AuthProvider>().setNabvarIndex(0);
          Navigator.of(context).pushNamed(RoutesName.HOME_URL);
        }else if(currentIndex == 1){
          context.read<AuthProvider>().setNabvarIndex(1);
          Navigator.of(context).pushNamed(RoutesName.PROFILE_URL);
        }else if(currentIndex == 2){
          context.read<AuthProvider>().setNabvarIndex(2);
          Navigator.of(context).pushNamed(RoutesName.INBOX_URL);
        }else{
          context.read<AuthProvider>().setNabvarIndex(3);
          Navigator.of(context).pushNamed(RoutesName.UPDATE_URL);
        }




        // context.goNamed(Routes.mainpage.name,
        //     params: {'tab': widget.configs[index].routeName});
      },
    );
  }
}

class BottomNavbarConfigs {
  final Icon icon;
  final String label;
  final String routeName;
  const BottomNavbarConfigs({
    required this.icon,
    required this.label,
    required this.routeName,
  });
}
