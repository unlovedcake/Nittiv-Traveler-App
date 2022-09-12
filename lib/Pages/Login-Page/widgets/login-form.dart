import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../Core/Router/routesname.dart';
import '../../../Core/Utils/nittiv-color.dart';
import '../../../Provider/auth-provider.dart';
import 'password-field.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final _emailCtrl = TextEditingController();
  static final _passwordCtrl = TextEditingController();

  String? validateEmail(String? email) {
    final emailPattern =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Field cannot be blank.';
    } else if (!emailPattern.hasMatch(email)) {
      return 'Invalid email.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/nittiv-logo-icon.png'),
          Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "LOGIN",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailCtrl,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    label: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: NittivColors.primaryGreen, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RepaintBoundary(
                  child: PasswordField(
                    passwordHidden: true,
                    controller: _passwordCtrl,
                    hintText: "Password",
                    textAlign: TextAlign.start,
                    onFieldSubmitted: (_) {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                colors: [
                  NittivColors.primaryGreen,
                  NittivColors.secondaryGreen,
                ],
              ),
            ),
            child: TextButton(
              onPressed: () {

                context.read<AuthProvider>().signIn(
                    _emailCtrl.text,
                    _passwordCtrl.text,
                    context);

              },
              style: TextButton.styleFrom(
                fixedSize: const Size(double.infinity, 40),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                primary: Colors.white,
              ),
              child: const Text('LOGIN'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 40,
            child: Center(
              child: Text(
                'OR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async{
                Navigator.of(context).pushNamed(RoutesName.HOME_URL,
                    );

              },
              style: TextButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                fixedSize: const Size(double.infinity, 40),
              ),
              child: const Text(
                'LOGIN WITH GOOGLE',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Don't have an account yet? ",
                ),
                TextSpan(
                  text: 'Register',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = (() {
                      Navigator.pushNamed(context, RoutesName.REGISTER_TRAVELER_URL);
                      //Navigator.of(context).pushNamed(RegistrationPage.route);
                    }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
