import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/screens/login_screen.dart';
import 'package:somaiya_project/utilities/network_helper.dart';
import 'package:somaiya_project/widgets/custom_snackbar.dart';
import 'package:somaiya_project/widgets/custom_text_field.dart';
import 'package:somaiya_project/widgets/submit_button.dart';

enum Dept {
  none,
  comps,
  it,
  extc,
  etrx,
  aids,
}

Map<Dept, int> deptID = {
  Dept.comps: 1,
  Dept.it: 2,
  Dept.aids: 3,
  Dept.extc: 4,
  Dept.etrx: 5,
};

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSpinning = false;
  Dept selectedDept = Dept.none;
  String selectedYear = 'Year';
  String name = '', email = '', phone = '', svvID = '', password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlurryModalProgressHUD(
      inAsyncCall: isSpinning,
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
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
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
                        onChangedCallback: (String? val) {
                          if (val != null) {
                            name = val;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        hintText: 'Somaiya Email',
                        textInputType: TextInputType.emailAddress,
                        onChangedCallback: (String? val) {
                          if (val != null) {
                            email = val;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        hintText: 'Phone',
                        textInputType: TextInputType.number,
                        onChangedCallback: (String? val) {
                          if (val != null) {
                            phone = val;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        hintText: 'SVV Net Id',
                        textInputType: TextInputType.number,
                        onChangedCallback: (String? val) {
                          if (val != null) {
                            svvID = val;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DeptDropDown(
                              value: selectedDept,
                              onChanged: (Dept? value) {
                                if (value != null) {
                                  setState(() {
                                    selectedDept = value;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                              child: YearDropDown(
                            value: selectedYear,
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() {
                                  selectedYear = value;
                                });
                              }
                            },
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        hintText: 'Password',
                        obscureText: true,
                        onChangedCallback: (String? val) {
                          if (val != null) {
                            password = val;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: SubmitButton(
                        onPressesCallback: () async {
                          if (name == '' ||
                              email == '' ||
                              phone == '' ||
                              svvID == '' ||
                              password == '' ||
                              selectedDept == Dept.none ||
                              selectedYear == 'Year') {
                            showErrorSnackbar(context,
                                'None of the given fields should be empty !');
                          } else {
                            setState(() {
                              isSpinning = true;
                            });
                            var response = await NetworkHelper.signUpAsStudent(name: name,email: email,phone: phone,svv: svvID,year: selectedYear,dept: deptID[selectedDept].toString(),password: password);
                            setState(() {
                              isSpinning = false;
                            });
                            if (response['message'] == 'Success'){
                              Navigator.pop(context);
                              showNormalSnackbar(context, 'Kindly Login Again With Email & Password');
                            } else {
                              showErrorSnackbar(context, 'An Error Occurred :(');
                            }
                          }
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
      ),
    ));
  }
}

class DeptDropDown extends StatelessWidget {
  final Dept value;
  final Function(Dept?) onChanged;

  const DeptDropDown({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kGray, borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Center(
        child: DropdownButton<Dept>(
          hint: const Text('Dept'),
          value: value,
          items: const [
            DropdownMenuItem(
              child: Text('Department'),
              value: Dept.none,
            ),
            DropdownMenuItem(
              child: Text('COMPS'),
              value: Dept.comps,
            ),
            DropdownMenuItem(
              child: Text('IT'),
              value: Dept.it,
            ),
            DropdownMenuItem(
              child: Text('EXTC'),
              value: Dept.extc,
            ),
            DropdownMenuItem(
              child: Text('ETRX'),
              value: Dept.etrx,
            ),
            DropdownMenuItem(
              child: Text('AI-DS'),
              value: Dept.aids,
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class YearDropDown extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const YearDropDown({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kGray, borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Center(
        child: DropdownButton<String>(
          hint: const Text('Dept'),
          value: value,
          items: const [
            DropdownMenuItem(
              child: Text('Year'),
              value: "Year",
            ),
            DropdownMenuItem(
              child: Text('FY'),
              value: 'FY',
            ),
            DropdownMenuItem(
              child: Text('SY'),
              value: 'SY',
            ),
            DropdownMenuItem(
              child: Text('TY'),
              value: 'TY',
            ),
            DropdownMenuItem(
              child: Text('LY'),
              value: 'LY',
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
