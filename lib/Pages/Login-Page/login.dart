import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/Utils/mobile-desktop-view.dart';
import '../../Core/Widgets/footer.dart';
import 'widgets/login-form.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenRatio = size.aspectRatio;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Image.asset(
          'icons/nittiv-logo-landscape-sm.png',
          color: View.isMobile(size.width)
              ? Theme.of(context).primaryColor
              : Theme.of(context).backgroundColor,
          alignment: Alignment.center,
        ),
        leadingWidth: 100,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: !View.isMobile(size.width) ? Colors.black.withOpacity(.3) : null,
          image: !View.isMobile(size.width)
              ? DecorationImage(
                  colorFilter: const ColorFilter.mode(
                    Colors.black45,
                    BlendMode.darken,
                  ),
                  image: const AssetImage('assets/images/register-traveler-bg.png'),
                  fit: screenRatio < 1.5
                      ? BoxFit.fitHeight
                      : screenRatio > 2
                          ? BoxFit.fitWidth
                          : BoxFit.fill,
                  alignment: const Alignment(-.6, -.8),
                )
              : null,
        ),
        child: SizedBox.expand(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                height: constraints.maxHeight,
                constraints: const BoxConstraints(minHeight: 700),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 500,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: const LoginForm(),
                      ),
                    ),
                    const Spacer(),
                    if (!View.isMobile(size.width) && size.height > 900)
                      const NittivFooter()
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
