import 'package:client/core/shared_service/form_validation_service.dart';
import 'package:client/core/shared_widgets/curve_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import '../../../core/core.dart';

import 'package:client/injection.dart';
import '../view_model/auth_view_model.dart';
import 'auth_view.dart';

class LoginView extends HookWidget {
  ValueNotifier<FormzStatus> _validationState = ValueNotifier(FormzStatus.pure);
  ValueNotifier<Password> _password = ValueNotifier(Password.pure());
  ValueNotifier<Email> _email = ValueNotifier(Email.pure());

  @override
  Widget build(BuildContext context) {
    _validationState = useState(FormzStatus.pure);
    _password = useState(Password.pure());
    _email = useState(Email.pure());

    return ResponsiveBuilder(
      builder: (context, media) => ViewModelBuilder.reactive(
        viewModelBuilder: () => getIt<AuthViewModel>(),
        builder: (context, AuthViewModel model, child) => AuthView(
          model: model,
          formCard: _loginForm(context, model, media),
        ),
      ),
    );
  }

  Widget _loginForm(context, AuthViewModel model, media) {
    return SingleChildScrollView(
      child: Container(
        color: AppTheme.primaryBackgroundColor,
        child: Column(children: [
          _topPart(context),
          SizedBox(height: media.screenSize.height * 0.1),
          _bottomPart(context, model, media),
          SizedBox(height: media.screenSize.height * 0.05),
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

  Widget _bottomPart(context, AuthViewModel model, media) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Column(
                children: [
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
                          _validationState.value =
                              Formz.validate([_email.value, _password.value]);
                        },
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      width: media.screenSize.width * 0.9,
                      child: TextFieldCustom(
                        obscureText: true,
                        hintText: "Password",
                        prefixIconData: Icons.lock,
                        borderSide: true,
                        textColor: Colors.white,
                        hintTextColor: Color(0xffaba7be),
                        backgroundColor: Color(0xff6a667d),
                        borderColor: Color(0xffaaa6bd),
                        prefixIconColor: AppTheme.primaryColorLight,
                        errorText: _password.value.status == FormzInputStatus.invalid
                            ? _password.value.passwordValidator.errorText
                            : null,
                        onChanged: (v) {
                          _password.value = Password.dirty(value: v);
                          _validationState.value =
                              Formz.validate([_email.value, _password.value]);
                        },
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButtonCustom(
                          width: MediaQuery.of(context).size.width * 0.5,
                          btnColor: AppTheme.primaryColorLight,
                          child: model.isBusy ?
                          SizedBox(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            height: 15,
                            width: 15,
                          ) :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Login"),
                              Icon(Icons.arrow_right_alt, color: Colors.white,)
                            ],
                          ),
                          onPressed: _validationState.value == FormzStatus.valid ?
                              () async {
                            await model.signInWithEmailAndPassword(
                                context,
                                _email.value.value.trim(),
                                _password.value.value.trim());
                          } : null
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/forgotPassword');
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                              height: 1.170731707317073,
                              color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signUp');
            },
            child: Column(
              children: [
                Text(
                    'Dont have an account?',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff8d8a9e)
                    )
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryColorLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
