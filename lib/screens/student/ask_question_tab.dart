import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/utilities/faculty_class.dart';
import 'package:somaiya_project/utilities/network_helper.dart';
import 'package:somaiya_project/utilities/shared_pref_manager.dart';
import "package:somaiya_project/widgets/custom_text_field.dart";
import "package:somaiya_project/widgets/submit_button.dart";
import "package:somaiya_project/widgets/custom_snackbar.dart";
import 'package:flutter/foundation.dart';

class AskAQuestionTab extends StatefulWidget {
  const AskAQuestionTab({Key? key}) : super(key: key);

  @override
  State<AskAQuestionTab> createState() => _AskAQuestionTabState();
}

class _AskAQuestionTabState extends State<AskAQuestionTab> {
  bool isSpinning = false;
  Faculty selectedFaculty = Faculty(-1, "NONE");
  String topic = '', question = '';

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
                  Container(
                    decoration: BoxDecoration(
                      color: kGray,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: DropdownSearch<Faculty>(
                      mode: Mode.DIALOG,
                      onFind: (String? s) async {
                        var response = await NetworkHelper.getAllTeachers();
                        if (response['message'] == 'Success') {
                          return Faculty.fromAPI(response);
                        } else {
                          return [Faculty(0, 'ERROR')];
                        }
                      },
                      onChanged: (Faculty? val) {
                        if (val != null) {
                          selectedFaculty = val;
                          if (kDebugMode) {
                            print(val.name);
                          }
                        }
                      },
                      showSearchBox: true,
                      itemAsString: (Faculty? f) {
                        if (f != null) {
                          return f.name;
                        } else {
                          return '';
                        }
                      },
                      dropdownSearchDecoration: const InputDecoration(
                        labelText: 'Faculty',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: CustomTextField(
                        hintText: 'Subject',
                        onChangedCallback: (String? value) {
                          if (value != null) {
                            topic = value;
                          }
                        }),
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
                      onChanged: (String? value) {
                        if (value != null) {
                          question = value;
                        }
                      },
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
                    child: SubmitButton(
                      onPressesCallback: () async {
                        setState(() {
                          isSpinning = true;
                        });
                        int sID = await SharedPrefManager.getId();
                        int fID = selectedFaculty.id;
                        if (question == '' || topic == '') {
                          showErrorSnackbar(context,
                              'Question and Subject Fields cannot be empty !');
                        } else if (fID == -1 || sID == -1) {
                          showErrorSnackbar(
                              context, "An Internal Error Occurred");
                        } else {
                          print(question + " " + '$sID' + topic + " " + "$fID");
                          var response = await NetworkHelper.postQuestion(
                              question, sID, topic, fID);

                          if (response['message'] == 'Success') {
                            showNormalSnackbar(context, 'Posted Successfully');
                            setState(() {});
                          } else {
                            showErrorSnackbar(context, 'An Error Occurred :(');
                          }
                        }
                        setState(() {
                          isSpinning = false;
                        });
                      },
                    ),
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
