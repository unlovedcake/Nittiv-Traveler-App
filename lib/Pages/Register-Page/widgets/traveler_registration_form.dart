import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Router/routesname.dart';
import '../../../Core/Utils/nittiv-color.dart';
import '../../../Models/UserModel.dart';
import '../../../Provider/auth-provider.dart';
import '../../Login-Page/widgets/password-field.dart';

class TravelerRegisterationForm extends StatefulWidget {
  const TravelerRegisterationForm({
    Key? key,
  }) : super(key: key);

  static final _emailCtrl = TextEditingController();
  static final _firstNameCtrl = TextEditingController();
  static final _lastNameCtrl = TextEditingController();
  static final _passwordCtrl = TextEditingController();

  @override
  State<TravelerRegisterationForm> createState() =>
      _TravelerRegisterationFormState();
}

class _TravelerRegisterationFormState extends State<TravelerRegisterationForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    final emailPattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Field cannot be blank.';
    } else if (!emailPattern.hasMatch(email)) {
      return 'Invalid email.';
    }
    return null;
  }



  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!,width: 1),

        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Email'),
              ),
              TextFormField(
                controller: TravelerRegisterationForm._emailCtrl,
                validator: validateEmail,
                decoration: const InputDecoration(
                  hintText: 'email@example.com',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('First Name'),
              ),
              TextFormField(
                controller: TravelerRegisterationForm._firstNameCtrl,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'Field cannot be blank.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Juan',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Last Name'),
              ),
              TextFormField(
                controller: TravelerRegisterationForm._lastNameCtrl,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'Field cannot be blank.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Dela Cruz',
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              RepaintBoundary(
                child: PasswordField(
                  passwordHidden: true,
                  controller: TravelerRegisterationForm._passwordCtrl,
                  hintText: "Password",
                  textAlign: TextAlign.start,
                  onFieldSubmitted: (_) {},
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      UserModel? user = UserModel();
                      user.firstName =
                          TravelerRegisterationForm._firstNameCtrl.text;
                      user.lastName = TravelerRegisterationForm._lastNameCtrl.text;
                      user.email = TravelerRegisterationForm._emailCtrl.text;
                      user.userType = "Traveler";

                      context.read<AuthProvider>().signUp(
                          TravelerRegisterationForm._passwordCtrl.text,
                          user,
                          context);


                    }

                  },
                  style: TextButton.styleFrom(
                    fixedSize: const Size(double.infinity, 40),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    primary: Colors.white,
                  ),
                  child: const Text('REGISTER'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    fixedSize: const Size(double.infinity, 40),
                  ),
                  child: const Text(
                    'REGISTER WITH GOOGLE',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Have an account? ",
                    ),
                    TextSpan(
                      text: 'Login instead',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() {
                          Navigator.pushNamed(context, RoutesName.LOGIN_URL);
                        }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
