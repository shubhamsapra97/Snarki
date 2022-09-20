import 'package:client/core/shared_service/form_validation_service.dart';
import 'package:client/core/shared_widgets/app_bar.dart';
import 'package:client/core/shared_widgets/button.dart';
import 'package:client/core/shared_widgets/text_field.dart';
import 'package:client/modules/profile/profiel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:stacked/stacked.dart';
import 'package:client/core/core.dart';

import 'package:client/injection.dart';

class ChangePassword extends HookWidget {
  ValueNotifier<FormzStatus> _validationState = ValueNotifier(FormzStatus.pure);
  ValueNotifier<Name> _currentPassword = ValueNotifier(Name.pure());
  ValueNotifier<Password> _password = ValueNotifier(Password.pure());
  ValueNotifier<RePassword> _repassword = ValueNotifier(RePassword.pure());

  @override
  Widget build(BuildContext context) {
    _validationState = useState(FormzStatus.pure);
    _password = useState(Password.pure());
    _repassword = useState(RePassword.pure());
    _currentPassword = useState(Name.pure());
    var media = MediaQuery.of(context).size;
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          context: context,
          title: Text(
            "S N A R K I",
            style: TextStyle(
                color: AppTheme.primaryColorLight,
                fontWeight: FontWeight.w900
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context, true);
              }),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(1))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldCustom(
                    hintText: "Current Password",
                    obscureText: true,
                    prefixIconData: Icons.lock,
                    borderSide: true,
                
                    backgroundColor: Colors.white,
                    errorText:
                        _currentPassword.value.status == FormzInputStatus.invalid
                            ? _currentPassword.value.nameValidator.errorText
                            : null,
                    onChanged: (v) {
                      _currentPassword.value = Name.dirty(value: v);
                      _validationState.value = Formz.validate([
                        _repassword.value,
                        _password.value,
                        _currentPassword.value,
                      ]);
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFieldCustom(
                    hintText: "Password",
                    obscureText: true,
                    prefixIconData: Icons.lock,
                    borderSide: true,
                   
                    backgroundColor: Colors.white,
                    errorText:
                        _password.value.status == FormzInputStatus.invalid
                            ? _password.value.passwordValidator.errorText
                            : null,
                    onChanged: (v) {
                      _password.value = Password.dirty(value: v);
                      _validationState.value = Formz.validate([
                        _password.value,
                        _currentPassword.value,
                        _repassword.value
                      ]);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldCustom(
                    hintText: "Re-type Password",
                    obscureText: true,
                    prefixIconData: Icons.lock,
                    borderSide: true,
                  
                    backgroundColor: Colors.white,
                    errorText:
                        _repassword.value.status == FormzInputStatus.invalid
                            ? _repassword.value.matchValidator.errorText
                            : null,
                    onChanged: (v) {
                      _repassword.value = RePassword.dirty(
                          password: _password.value.value, value: v);
                      _validationState.value = Formz.validate([
                        _password.value,
                        _currentPassword.value,
                        _repassword.value
                      ]);
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: media.width,
                    height: 48,
                    child: RaisedButtonCustom(
                      btnColor: AppTheme.primaryBackgroundColor,
                      borderColor: Colors.white,
                      child:  model.isBusy
                      ? SizedBox(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                        height: 15,
                        width: 15
                      ) :
                      Text(
                        "Update",
                      ),
                      onPressed: _validationState.value == FormzStatus.valid
                        ? () async {
                          await model.changePassword(
                              newPassword: _repassword.value.value.trim(),
                              currentPassword:
                                  _currentPassword.value.value.trim());
                        } : null
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
