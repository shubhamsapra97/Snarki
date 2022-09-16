import 'package:flutter/material.dart';
import 'package:client/injection.dart';
import 'package:client/core/models/models.dart';
import 'package:client/core/shared_service/feedback_service.dart';
import './utils/validator.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> with Validator {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final double minValue = 8.0;
  final _feedbackTypeList = <String>["Comment", "Bug"];

  String _feedbackType = "";

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  initState() {
    _feedbackType = _feedbackTypeList[0];
    super.initState();
  }

  Widget _buildAssetHeader() {
    return Container(
      width: double.maxFinite,
      height: 230.0,
      child: Container(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: new AssetImage("assets/feedback.png"),
              fit: BoxFit.cover,
          ),
      ),
    );
  }

  Widget _buildCategory() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: minValue * 2, horizontal: minValue * 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Feedback type",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            onChanged: (String? type) {
              setState(() {
                if (type != null) _feedbackType = type;
              });
            },
            hint: Text(
              "$_feedbackType",
              style: TextStyle(fontSize: 16.0),
            ),
            items: _feedbackTypeList
                .map((type) => DropdownMenuItem<String>(
                  child: Text("$type"),
                  value: type,
                )
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _nameController,
        validator: usernameValidator,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            contentPadding:
            EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Full  Name',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.text,
        validator: validateEmail,
        // onChanged: (String value) {},
        // readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: UnderlineInputBorder(),
            contentPadding:
            EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _messageController,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            labelText: 'Description',
            contentPadding:
            EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    var submitFeedback = () async {
      var snackBar;
      if (_feedbackType == '' ||
          _nameController.text == '' ||
          _emailController.text == '' ||
          _messageController.text == ''
      ) {
        snackBar = SnackBar(content: Text('Fill in the fields.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      try {
        await getIt<FeedbackService>().createFeedback(UserFeedback(
            feedbackType: _feedbackType,
            fullName: _nameController.text,
            email: _emailController.text,
            description: _messageController.text
        ));
        Navigator.pop(context, true);
        snackBar = SnackBar(content: Text('Feedback Submitted!'));
      } catch(e) {
        snackBar = SnackBar(content: Text(e.toString()));
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black87,
          onPressed: () {
            Navigator.pop(context, true);
          }),
        elevation: 1,
        title: Text(
          "Leave feedback",
          style: TextStyle(color: Colors.black87),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: submitFeedback,
              child: Text("SEND")
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildAssetHeader(),
          _buildCategory(),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: minValue,
                ),
                _buildName(),
                SizedBox(
                  height: minValue * 3,
                ),
                _buildEmail(),
                SizedBox(
                  height: minValue * 3,
                ),
                _buildDescription(),
                SizedBox(
                  height: minValue * 3,
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}