import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String domain = 'http://10.0.2.2:5000';

class NetworkHelper {
  static Future<Map> loginAsStudent(String email, String password) async {
    print('here');
    Uri url = Uri.parse('$domain/login');
    var response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode == 200) {
      Map decoded = jsonDecode(response.body) as Map;
      return decoded;
    } else {
      return {'message': 'An Error Occured :('};
    }
  }

  static Future<Map> signUpAsStudent(
    String name,
    String email,
    String phone,
    String svv,
    String year,
    String dept,
    String password,
  ) async {
    Uri url = Uri.parse('$domain/studentreg');
    var response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'phone': phone.toString(),
        'svv_id': svv.toString(),
        'year': year,
        'department_name': dept,
        'password': password,
      },
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body) as Map;
      return decoded;
    } else {
      return {'message': 'An Error Occured :('};
    }
  }

  static Future<Map> postQuestion(
      String question, int sID, String subject, int fID) async {
    Uri url = Uri.parse('$domain/postQuestion');
    var response = await http.post(
      url,
      body: {
        'question': question,
        'stu_id': sID,
        'topic': subject,
        'faculty_id': fID,
      },
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      Map decoded = jsonDecode(response.body) as Map;
      return decoded;
    } else {
      return {'message': 'An Error Occurred :('};
    }
  }

  static Future<Map> getAllQuestionsForFaculty(int facID) async {
    var url = Uri.parse('$domain/getAllQuestionsTeacher');
    var response = await http.post(url, body: {
      'fac_id': facID,
    }, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      Map decoded = jsonDecode(response.body) as Map;
      return decoded;
    } else {
      return {'message': 'An Error Occurred :('};
    }
  }

  static Future<Map> getAllQuestionsForStudent(int sID) async {
    Uri url = Uri.parse('$domain/getAllQuestions');
    var response = await http.post(url, body: {
      'stu_id': sID,
    }, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      Map decoded = jsonDecode(response.body) as Map;
      return decoded;
    } else {
      return {'message': 'An Error Occurred :('};
    }
  }

  static Future<Map> postAnswer(int qID, String answer) async {
    Uri url = Uri.parse('$domain/postAnswer');
    var response = await http.post(
      url,
      body: {
        'quest_id': qID.toString(),
        'answer': answer,
      },
      headers: {'Context-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      Map decoded = jsonDecode(response.body) as Map;
      return decoded;
    } else {
      return {'message': 'An Error Occurred :('};
    }
  }
}
