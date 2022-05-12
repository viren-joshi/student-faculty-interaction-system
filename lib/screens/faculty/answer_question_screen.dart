import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/utilities/network_helper.dart';
import 'package:somaiya_project/widgets/custom_snackbar.dart';
import 'package:somaiya_project/widgets/submit_button.dart';

class AnswerQuestionScreen extends StatefulWidget {
  final String question;
  final int qID;
  const AnswerQuestionScreen({Key? key, required this.question, required this.qID}) : super(key: key);

  @override
  State<AnswerQuestionScreen> createState() => _AnswerQuestionScreenState();
}

class _AnswerQuestionScreenState extends State<AnswerQuestionScreen> {
  String answer = '';
  bool isSpinning = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: kGray, size: 45.0),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 5.0),
              child: Image.asset('images/somaiya_logo.jpg'),
            ),
            const SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/somaiya_trust.jpg'),
            )
          ],
          elevation: 0.0,
          // toolbarHeight: 75.0,
        ),
        body: BlurryModalProgressHUD(
          inAsyncCall: isSpinning,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Answer Question',
                          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      CustomTextContainer(
                        text: widget.question,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: kGray,
                            hintText: 'Answer',
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          onChanged: (String? value) {
                            if (value != null) {
                              answer = value;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SubmitButton(onPressesCallback: () async {
                          setState(() {
                            isSpinning = true;
                          });
                          print(widget.qID);
                          var response = await NetworkHelper.postAnswer(widget.qID, answer);
                          setState(() {
                            isSpinning = false;
                          });
                          if (response['message'] == 'Success'){
                            Navigator.pop(context);
                            showNormalSnackbar(context, 'Answer Posted !');
                          } else {
                            showErrorSnackbar(context, 'An Error Occurred :(');
                          }
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String text;
  const CustomTextContainer({
    Key? key, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: kGray,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
