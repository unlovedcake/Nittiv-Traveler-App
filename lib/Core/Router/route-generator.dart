import 'package:flutter/material.dart';
import '../../Pages/Login-Page/login.dart';
import '../../Pages/Main-Page/Inbox-Page/inbox-page.dart';
import '../../Pages/Main-Page/Profile-Page/profile-page.dart';
import '../../Pages/Main-Page/Update-Page/update-page.dart';
import '../../Pages/Main-Page/nittiv-main.dart';
import '../../Pages/Register-Page/register.dart';
import '../Utils/nittive-theme.dart';
import 'generate-route.dart';
import 'routesname.dart';

class RouteGenerator {
  static Widget _errorRoute() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: NittivTheme().lightTheme,
      home: Scaffold(
        body: Center(
          child: Text("ERROR"),
        ),
      ),
    );
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final  widget = settings.arguments;
    final currentIndex = settings.arguments;

    switch (settings.name) {
      case RoutesName.LOGIN_URL:
        return GeneratePageRoute(widget: const Login(), routeName: settings.name);

      case RoutesName.REGISTER_URL:
        return GeneratePageRoute(widget: const Register(), routeName: settings.name);

      case RoutesName.REGISTER_OPERATOR_URL:
        return GeneratePageRoute(widget: const Register(), routeName: settings.name);
      case RoutesName.REGISTER_TRAVELER_URL:
        return GeneratePageRoute(widget: const Register(), routeName: settings.name);

      case RoutesName.HOME_URL:
        return GeneratePageRoute(widget:  NittivHome(), routeName: settings.name);

      case RoutesName.PROFILE_URL:
        return GeneratePageRoute(widget:  ProfilePage(), routeName: settings.name);

      case RoutesName.INBOX_URL:
        return GeneratePageRoute(widget:  InboxPage(), routeName: settings.name);

      case RoutesName.UPDATE_URL:
        return GeneratePageRoute(widget:  UpdatePage(), routeName: settings.name);



    // case RoutesName.REGISTER_OPERATOR_URL:
      //   return GeneratePageRoute(
      //       widget: OperatorRegisterationForm(), routeName: settings.name);
      //
      // case RoutesName.REGISTER_TRAVELER_URL:
      //   return GeneratePageRoute(
      //       widget: TravelerRegisterationForm(), routeName: settings.name);

      // case RoutesName.REGISTER_OPERATOR_URL:
      //   if (userType is Object) {
      //     return GeneratePageRoute(
      //         widget: RegistrationPage(userType: userType as NittivUserType),
      //         routeName: settings.name);
      //   }
      //   break;
      //
      // case RoutesName.REGISTER_TRAVELER_URL:
      //   if (userType is Object) {
      //     return GeneratePageRoute(
      //         widget: RegistrationSequence(userType: userType as NittivUserType),
      //         routeName: settings.name);
      //   }
      //   break;

      // return GeneratePageRoute(
      //     widget: const RegistrationSequence(userType: userType),
      //     routeName: settings.name);

      default:
        return GeneratePageRoute(widget: _errorRoute(), routeName: settings.name);
    }
  }
}
