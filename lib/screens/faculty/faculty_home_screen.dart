import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';

class FacultyHomeScreen extends StatefulWidget {
  const FacultyHomeScreen({Key? key}) : super(key: key);

  @override
  State<FacultyHomeScreen> createState() => _FacultyHomeScreenState();
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: const Color(0xCC680C25),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'All Questions',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 2.0,
                    color: Color(0xFF082795),
                  );
                },
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  bool isAnswered = false;
                  if (index % 2 == 0) {
                    isAnswered = true;
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Question :',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: kHyperlinkColor,
                            fontSize: 18.0,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                              'ABCD EFGH IKLSFJKJEHG HDKJGHRT HKJHJDGJKT KJDGKJRHT'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(isAnswered ? Icons.schedule : Icons.done),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: kLightColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 35.0),
                                    child: Text(
                                      'Answer',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
