import 'package:flutter/material.dart';
import 'package:test_googlesheets/controller/form_controller.dart';
import 'package:test_googlesheets/model/feedback_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Sheets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        emailController.text,
        mobileNumberController.text,
        feedbackController.text,
      );

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          _showSnackbar("Feedback Submitted");
        } else {
          _showSnackbar("Error Occured!");
        }
      });

      _showSnackbar("Submitting Feedback");

      formController.submitForm(feedbackForm);
    }
  }

  _showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a Valid Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (!value.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: mobileNumberController,
                      validator: (value) {
                        if (value.trim().length != 10) {
                          return 'Enter 10 Digit Mobile Number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                    ),
                    TextFormField(
                      controller: feedbackController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a Valid Feedback';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Feedback',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Submit Feedback'),
            )
          ],
        ),
      ),
    );
  }
}
