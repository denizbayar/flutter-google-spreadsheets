import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:test_googlesheets/model/feedback_model.dart';

class FormController {
  final void Function(String) callback;

  static const String URL =
      "https://script.google.com/macros/s/AKfycbywkAcP9hY6g2Ri9G_CiR89LRnzYbe_46yHRQ9bIlqVtP14ytLl/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    try {
      await http.get(URL + feedbackForm.toParams()).then(
          (response) => callback(convert.jsonDecode(response.body)['status']));
    } catch (e) {
      print(e);
    }
  }
}
