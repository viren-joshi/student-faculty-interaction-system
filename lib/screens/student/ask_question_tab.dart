import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/utilities/network_helper.dart';
import "package:somaiya_project/widgets/custom_text_field.dart";
import "package:somaiya_project/widgets/submit_button.dart";
import "package:somaiya_project/widgets/custom_snackbar.dart";

class AskAQuestionTab extends StatefulWidget {
  const AskAQuestionTab({Key? key}) : super(key: key);

  @override
  State<AskAQuestionTab> createState() => _AskAQuestionTabState();
}

class _AskAQuestionTabState extends State<AskAQuestionTab> {
  bool isSpinning = false;

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isSpinning,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CustomTextField(
                        hintText: 'Choose Faculty',
                        onChangedCallback: (String? value) {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CustomTextField(
                        hintText: 'Subject',
                        onChangedCallback: (String? value) {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: kGray,
                        hintText: 'Question',
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      onChanged: (String? value) {},
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.only(bottom: 10.0),
                  //   child: ListTile(
                  //     tileColor: kGray,
                  //     dense: true,
                  //     leading: Icon(Icons.attach_file),
                  //     title: Text(
                  //       'Attach File Here',
                  //       style: TextStyle(fontWeight: FontWeight.w500),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SubmitButton(onPressesCallback: () async {
                      setState(() {
                        isSpinning = true;
                      });
                      // var response = await NetworkHelper.postQuestion(question, sID, subject, fID);
                      setState(() {
                        isSpinning = false;
                      });

                      showNormalSnackbar(context, 'Posted Successfully');
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
