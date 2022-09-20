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
      child: Container(
        color: AppTheme.primaryBackgroundColor,
        child: Column(children: [
          _topPart(context),
          SizedBox(height: media.screenSize.height * 0.1),
          _bottomPart(model, media),
          SizedBox(height: media.screenSize.height * 0.1),
          _lastPart(context,model, media),
          SizedBox(height: media.screenSize.height * 0.2),
        ]),
      ),
    );
  }

  Widget _topPart(context) {
    bool isIos = Theme
        .of(context)
        .platform == TargetPlatform.iOS;
    return Stack(
      children: [
        ClipPath(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          clipper: CurveClipper(),
        ),
        Positioned(
          left: 20,
          bottom: 0,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome!",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Color(0xfff5cdaa),
                        fontWeight: FontWeight.w200,
                        fontSize: 30
                    )),
                SizedBox(
                  height: 8,
                ),
                Text(
                    "Snarki",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Color(0xfff5cdaa),
                        fontWeight: FontWeight.w400,
                        fontSize: 30
                    )),
              ]),
        ),
        if (isIos) ...[
          Positioned(
            left: 10,
            top: 50,
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                iconSize: 35,
                onPressed: () {
                  Navigator.pop(context, true);
                }),
          )],
      ],
    );
  }

  Widget _lastPart(context, AuthViewModel model, media) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: media.screenSize.width * 0.7,
            height: 48,
            child: RaisedButtonCustom(
                btnColor: AppTheme.primaryColorLight,
                child: model.isBusy
                    ? SizedBox(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  height: 15,
                  width: 15,
                )
                    :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign Up"),
                    Icon(Icons.arrow_right_alt, color: Colors.white)
                  ],
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
                    style: TextStyle(color: Color(0xff8d8a9e))
                ),
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
      ),
    );
  }

  Widget _bottomPart(model, media) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: media.screenSize.width * 0.9,
            child: TextFieldCustom(
              hintText: "Name",
              prefixIconData: Icons.person,
              borderSide: true,
              textColor: Colors.white,
              hintTextColor: Color(0xffaba7be),
              backgroundColor: Color(0xff6a667d),
              prefixIconColor: AppTheme.primaryColorLight,
              borderColor: Color(0xffaaa6bd),
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
            width: media.screenSize.width * 0.9,
            child: TextFieldCustom(
              hintText: "Email",
              prefixIconData: Icons.email,
              borderSide: true,
              textColor: Colors.white,
              hintTextColor: Color(0xffaba7be),
              backgroundColor: Color(0xff6a667d),
              prefixIconColor: AppTheme.primaryColorLight,
              borderColor: Color(0xffaaa6bd),
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
            width: media.screenSize.width * 0.9,
            child: TextFieldCustom(
              hintText: "Password",
              obscureText: true,
              prefixIconData: Icons.lock,
              borderSide: true,
              textColor: Colors.white,
              hintTextColor: Color(0xffaba7be),
              backgroundColor: Color(0xff6a667d),
              prefixIconColor: AppTheme.primaryColorLight,
              borderColor: Color(0xffaaa6bd),
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
            width: media.screenSize.width * 0.9,
            child: TextFieldCustom(
              hintText: "Re-type Password",
              obscureText: true,
              prefixIconData: Icons.lock,
              borderSide: true,
              textColor: Colors.white,
              hintTextColor: Color(0xffaba7be),
              backgroundColor: Color(0xff6a667d),
              prefixIconColor: AppTheme.primaryColorLight,
              borderColor: Color(0xffaaa6bd),
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
