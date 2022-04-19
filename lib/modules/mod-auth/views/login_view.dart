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
      child: Column(children: [
        _topPart(context),
        SizedBox(height: media.screenSize.height * 0.05),
        _bottomPart(context, model, media),
        SizedBox(height: media.screenSize.height * 0.1),
        _lastPart(context, model, media),
        SizedBox(height: 32),
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
                    Text("Welcome!",
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Color(0xfff5cdaa),
                            fontWeight: FontWeight.bold
                        ))
                  ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                  "We'd have thrown party to celebrate your come back. We gotta get back to work!",
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
                        "Login",
                      ),
                onPressed: _validationState.value == FormzStatus.valid
                    ? () async {
                        await model.signInWithEmailAndPassword(
                            context,
                            _email.value.value.trim(),
                            _password.value.value.trim());
                      }
                    : null)),
        SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/signUp');
          },
          child: StyledText(
            inlineSpans: [
              TextSpan(
                  text: 'Dont have an account?',
                  style: Theme.of(context).textTheme.bodyText2),
              TextSpan(
                text: '  Register',
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

  Widget _bottomPart(context, AuthViewModel model, media) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                _validationState.value =
                    Formz.validate([_email.value, _password.value]);
              },
            )),
        SizedBox(
          height: 16,
        ),
        SizedBox(
            width: media.screenSize.width * 0.7,
            child: TextFieldCustom(
              obscureText: true,
              hintText: "Password",
              prefixIconData: Icons.lock,
              borderSide: true,
              backgroundColor: Colors.white,
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
          height: 32,
        ),
        SizedBox(
          width: media.screenSize.width * 0.7,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/forgotPassword');
            },
            child: Text(
              'Forgot password ?',
              style: TextStyle(
                height: 1.170731707317073,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
