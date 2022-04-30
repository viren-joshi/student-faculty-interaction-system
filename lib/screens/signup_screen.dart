import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/screens/login_screen.dart';
import 'package:somaiya_project/widgets/custom_text_field.dart';
import 'package:somaiya_project/widgets/submit_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isTeacherSelected = true;

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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            decoration: BoxDecoration(
                              color:
                                  isTeacherSelected ? kDarkColor : kLightColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: TextButton(
                              onPressed: () => setState(() {
                                isTeacherSelected = true;
                              }),
                              child: const Center(
                                child: Text(
                                  'Teachers',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            decoration: BoxDecoration(
                              color:
                                  isTeacherSelected ? kLightColor : kDarkColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: TextButton(
                              onPressed: () => setState(() {
                                isTeacherSelected = false;
                              }),
                              child: const Center(
                                child: Text(
                                  'Student',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      hintText: 'Phone',
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      hintText: 'SVV Net Id',
                      onChangedCallback: (String? val) {},
                    ),
                  ),
                  isTeacherSelected
                      ? const SizedBox.shrink()
                      : Padding(
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: SubmitButton(
                      onPressesCallback: () {},
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
