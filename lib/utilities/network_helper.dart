import 'dart:convert';

import 'package:http/http.dart' as http;

const String domain = '';

class NetworkHelper {
  static Future<Map> loginAsStudent(String email, String password) async {
    Uri url = Uri.parse('$domain/login');
    var response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
      headers: {'Content-Type': 'application/json'},
    );
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
    int phone,
    int svv,
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
