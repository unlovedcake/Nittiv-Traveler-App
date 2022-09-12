import 'package:flutter/material.dart';
import 'package:nittiv_new_version/Provider/auth-provider.dart';
import 'package:provider/provider.dart';
import '../../Core/Utils/mobile-desktop-view.dart';
import '../../Core/Widgets/footer.dart';
import '../../Desktop-Or-Mobile-View/desktop-mobile.dart';
import 'widgets/button-register.dart';
import 'widgets/operator_registration_form.dart';
import 'widgets/traveler_registration_form.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isOperator = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    _isOperator =
        Provider.of<AuthProvider>(context, listen: false).getOperatorOrTraveler;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DesktopMobile(
              mobile: Container(
                height: size.height,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Image.asset(
                      _isOperator ? "assets/images/register-operator-bg.png"
                      : "assets/images/register-traveler-bg.png",
                      fit: BoxFit.cover,
                      height: 400,
                      width: 600,
                      // height: View.isMobile(size.height) ? 100 : null,
                    ),
                  ),

                  Positioned(
                      top: 380,
                      right: 60,
                      left: 60,
                      bottom: 0,
                      child: _isOperator
                          ? OperatorRegisterationForm()
                          : TravelerRegisterationForm()),
                ]),
              ),
              desktop: Wrap(
                alignment: WrapAlignment.center,
                spacing: 70,
                children: [
                  Stack(children: [
                    Image.asset(
                      _isOperator ? "assets/images/register-operator-bg.png"
                          : "assets/images/register-traveler-bg.png",
                      fit: BoxFit.cover,
                      height: 700,
                      width: 700,
                      // height: View.isMobile(size.height) ? 100 : null,
                    ),
                    Positioned(
                      top: 250,
                      right: 160,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              _isOperator
                                  ? 'REGISTER AS OPERATOR \n'
                                  : 'REGISTER AS TRAVELER \n',
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                _isOperator
                                    ? 'Grow your business post, contents,\nand offer booking services \n'
                                    : 'Find and book wellness spots, \n destination and activities \n',
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 25,
                                    color: Color(0xff005046),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              'Became and affilliate post, content and \n offer booking to your travel\n',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            ButtonRegister(isOperator: _isOperator)
                          ],
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    width: size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 128,
                          width: 128,
                          child: Image.asset('assets/images/form-header-img.png'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        _isOperator
                            ? OperatorRegisterationForm()
                            : TravelerRegisterationForm()
                      ],
                    ),
                  ),
                ],
              ),
            ),


            if (View.isDesktop(size.width)) const NittivFooter(),
          ],
        ),
      ),
    );
  }
}
