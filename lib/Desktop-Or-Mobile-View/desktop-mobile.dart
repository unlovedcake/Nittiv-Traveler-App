import 'package:flutter/cupertino.dart';

class DesktopMobile extends StatelessWidget {
  Widget? mobile;
  Widget? tablet;
  Widget? desktop;

  DesktopMobile({Key? key, this.mobile, this.tablet, this.desktop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= 768) {
        return mobile!;
      } else {
        return desktop!;
      }
    });
  }
}
