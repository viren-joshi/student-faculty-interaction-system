import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isTeacherSelected = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            decoration: BoxDecoration(
                              color: isTeacherSelected ? kDarkColor : kLightColor,
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
                              color: isTeacherSelected? kLightColor : kDarkColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                  isTeacherSelected ?
                    const SizedBox.shrink() :
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
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: const BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextButton(
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        onPressed: () {},
                      ),
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

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String?) onChangedCallback;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.onChangedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: kGray,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black45,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChangedCallback,
    );
  }
}
