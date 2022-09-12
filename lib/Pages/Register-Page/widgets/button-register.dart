import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Router/routesname.dart';
import '../../../Core/Utils/nittiv-color.dart';
import '../../../Provider/auth-provider.dart';

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({
    Key? key,
    required bool isOperator,
  })  : _isOperator = isOperator,
        super(key: key);

  final bool _isOperator;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: NittivColors.primaryGreen,
          shadowColor: Colors.white,
          elevation: 2,
          side: BorderSide(color: Colors.cyan)),
      onPressed: () {
        if (_isOperator == true) {
          context.read<AuthProvider>().setOperatorOrTraveler(false);

          Navigator.pushNamed(context, RoutesName.REGISTER_TRAVELER_URL);
        } else {
          context.read<AuthProvider>().setOperatorOrTraveler(true);
          Navigator.pushNamed(context, RoutesName.REGISTER_OPERATOR_URL);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          _isOperator ? "REGISTER AS TRAVELER INSTEAD" : "REGISTER AS OPERATOR INSTEAD",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
