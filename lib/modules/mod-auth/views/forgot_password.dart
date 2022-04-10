import 'package:client/core/shared_service/form_validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../core/core.dart';
import 'package:client/injection.dart';
import '../view_model/auth_view_model.dart';
import 'auth_view.dart';

class ForgotPasswordView extends HookWidget {
  ValueNotifier<Email> _email = ValueNotifier(Email.pure());
  @override
  Widget build(BuildContext context) {
    _email = useState(Email.pure());
    return ResponsiveBuilder(
      builder: (context, media) => ViewModelBuilder.reactive(
        viewModelBuilder: () => getIt<AuthViewModel>(),
        builder: (context, AuthViewModel model, child) => AuthView(
          // appBar: null,
          model: model,
          formCard: _loginForm(context, model, media),
        ),
      ),
    );
  }

  Widget _loginForm(context, AuthViewModel model, media) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          backgroundColor: Colors.transparent,
          title: Text(
            "Recover Password",
            style: TextStyle(
                fontSize: 25,
                color: AppTheme.SnarkiTextColor,
                fontWeight: FontWeight.bold
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 100,
            ),
            Text(
                'Enter the email of your \n account and we will send you the recovery link\n',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(
              height: 100,
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
                  },
                )),
            SizedBox(
              height: media.screenSize.height * 0.3,
            ),
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
                          ) :
                          Text(
                            "Submit",
                          ),
                      onPressed: _email.value.status == FormzInputStatus.valid
                          ? () async {
                              // TODO: Check if valid email and is registered.
                              model.sendPasswordResetEmail(
                                  _email.value.value.trim());
                            }
                          : null),
            ),
          ]),
        ),
      ),
    );
  }
}
