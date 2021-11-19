import 'package:client/core/shared_service/form_validation_service.dart';
import 'package:client/core/shared_widgets/curve_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:formz/formz.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import '../../../core/core.dart';
import 'package:client/injection.dart';
import 'auth_view.dart';

import '../view_model/auth_view_model.dart';
import 'login_view.dart';

class SignUpView extends HookWidget {
  ValueNotifier<FormzStatus> _validationState = ValueNotifier(FormzStatus.pure);
  ValueNotifier<Password> _password = ValueNotifier(Password.pure());
  ValueNotifier<RePassword> _repassword = ValueNotifier(RePassword.pure());
  ValueNotifier<Email> _email = ValueNotifier(Email.pure());
  ValueNotifier<Name> _name = ValueNotifier(Name.pure());

  @override
  Widget build(BuildContext context) {
    _validationState = useState(FormzStatus.pure);
    _email = useState(Email.pure());
     _name = useState(Name.pure());

    _password = useState(Password.pure());
    _repassword = useState(RePassword.pure());

    return ResponsiveBuilder(
      builder: (context, media) => ViewModelBuilder.reactive(
        viewModelBuilder: () => getIt<AuthViewModel>(),
        builder: (context, AuthViewModel model, child) => AuthView(
          model: model,
          formCard: _signupForm(context, model, media),
        ),
      ),
    );
  }

  Widget _signupForm(context, AuthViewModel model, media) {
    return SingleChildScrollView(
      child: Column(children: [
        _topPart(context),
        SizedBox(height: media.screenSize.height * 0.01),
        _bottomPart(model, media),
        SizedBox(height: media.screenSize.height * 0.1),
        _lastPart(context,model, media)
      ]),
    );
  }

  Widget _topPart(context) {
    return ClipPath(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
          color: Color(0xff5d5b6a),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Color(0xfff5cdaa),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
              Text("Welcome",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color:  Color(0xfff5cdaa), fontWeight: FontWeight.bold))
            ]),
              SizedBox(
                height: 16,
              ),
              Text(
                  "We are so proud to have you onboard. Discover your favourite food restaurants with Snarki",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.white,
                      )),
            ]),
      ),
      clipper: CurveClipper(),
    );
  }

  Widget _lastPart(context, AuthViewModel model, media) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: media.screenSize.width * 0.7,
          height: 48,
          child: RaisedButtonCustom(
              child: model.isBusy
                  ? SizedBox(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    height: 15,
                    width: 15,
                  )
                  : Text(
                      "Sign Up",
                    ),
              onPressed: _validationState.value == FormzStatus.valid
                    ? () async {
                      
                await model.signUpWithEmailAndPassword(
                    context: context,
                    email: _email.value.value.trim(),
                    password: _password.value.value.trim(),
                    name: _name.value.value.trim());
              } : null),
        ),
        SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
          },
          child:  StyledText(
            inlineSpans: [
              TextSpan(
                  text: 'Already have an account?',
                  style: Theme.of(context).textTheme.bodyText2),
              TextSpan(
                text: '  Login',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryColorLight),
              ),
            ],
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _bottomPart(model, media) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: media.screenSize.width * 0.7,
            child: TextFieldCustom(
              hintText: "Name",
              prefixIconData: Icons.person,
              borderSide: true,
           
              backgroundColor: Colors.white,
              errorText: _name.value.status == FormzInputStatus.invalid
                  ? _name.value.nameValidator.errorText
                  : null,
              onChanged: (v) {
                _name.value = Name.dirty(value: v);
                _validationState.value = Formz.validate(
                    [_email.value, _password.value, _name.value, _repassword.value]);
              },
            ),
            ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
            width: media.screenSize.width * 0.7,
            child: TextFieldCustom(
              hintText: "Email",
              prefixIconData: Icons.email,
              borderSide: true,
           
              backgroundColor: Colors.white,
             
              errorText: _email.value.status == FormzInputStatus.invalid
                  ? _email.value.emailValidator.errorText
                  : null,
              onChanged: (v) {
                _email.value = Email.dirty(value: v);
                _validationState.value = Formz.validate(
                    [_email.value, _password.value, _name.value, _repassword.value]);
              },
            ),),
        SizedBox(
          height: 16,
        ),
        SizedBox(
            width: media.screenSize.width * 0.7,
            child: TextFieldCustom(
              hintText: "Password",
              obscureText: true,
              prefixIconData: Icons.lock,
              borderSide: true,
            
              backgroundColor: Colors.white,
              errorText: _password.value.status == FormzInputStatus.invalid
                  ? _password.value.passwordValidator.errorText
                  : null,
              onChanged: (v) {
                _password.value = Password.dirty(value: v);
                _validationState.value = Formz.validate(
                    [_email.value, _password.value, _name.value, _repassword.value]);
              },
            )),
             SizedBox(
          height: 16,
        ),
        SizedBox(
            width: media.screenSize.width * 0.7,
            child: TextFieldCustom(
              hintText: "Re-type Password",
              obscureText: true,
              prefixIconData: Icons.lock,
              borderSide: true,
            
              backgroundColor: Colors.white,
              errorText: _repassword.value.status == FormzInputStatus.invalid
                  ? _repassword.value.matchValidator.errorText
                  : null,
              onChanged: (v) {
                _repassword.value = RePassword.dirty(password : _password.value.value ,value: v);
                _validationState.value = Formz.validate(
                    [_email.value, _password.value, _name.value, _repassword.value]);
              },
            )),
      ],
    );
  }
}
