class FeedbackForm {
  final String _name;
  final String _email;
  final String _mobileNumber;
  final String _feedback;

  FeedbackForm(this._name, this._email, this._mobileNumber, this._feedback);

  String toParams() =>
      "?name=$_name&email=$_email&mobileNumber=$_mobileNumber&feedback=$_feedback";
}
