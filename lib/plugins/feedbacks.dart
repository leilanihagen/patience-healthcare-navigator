import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class FeedbackForm {
  String screen;
  String feedback;
  FeedbackForm(this.screen, this.feedback);
  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['screen']}", "${json['feedback']}");
  }
  Map toJson() => {'screen': screen, 'feedback': feedback};
}

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbwi8TywfWGfq0wOVC6JqC6_u0JeIrPlb7r6V228Wa7CQFuMdWrsx-mTybsySz6bkfTNzg/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http
          .post(Uri.parse(URL), body: feedbackForm.toJson())
          .then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http
              .get(
            Uri.parse(url!),
          )
              .then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print("here");
      print(e);
    }
  }
}
