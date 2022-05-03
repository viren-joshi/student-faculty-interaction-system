import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/screens/login_screen.dart';
import 'package:somaiya_project/screens/student/student_home_screen.dart';
import 'package:somaiya_project/widgets/custom_text_field.dart';
import 'package:somaiya_project/widgets/submit_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 5.0),
          child: Image.asset('images/somaiya_logo.jpg'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/somaiya_trust.jpg'),
          )
        ],
        elevation: 0.0,
        // toolbarHeight: 75.0,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sign Up',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "For Students Only",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      hintText: 'Full Name',
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      hintText: 'Somaiya Email',
                      textInputType: TextInputType.emailAddress,
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      hintText: 'Phone',
                      textInputType: TextInputType.number,
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      hintText: 'SVV Net Id',
                      textInputType: TextInputType.number,
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: 'Dept',
                            onChangedCallback: (String? val) {},
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: CustomTextField(
                            hintText: 'Year',
                            onChangedCallback: (String? val) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      hintText: 'Password',
                      obscureText: true,
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: SubmitButton(
                      onPressesCallback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentHomeScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      'Already have an Account ? Tap Here !',
                      style: TextStyle(color: kHyperlinkColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
