import 'package:client/core/shared_service/auth_service.dart';
import 'package:client/core/shared_service/form_validation_service.dart';

import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ProfileViewModel extends BaseViewModel{
  final AuthService _authService;
  final DialogService _dialogService;

  ProfileViewModel( this._authService, this._dialogService);

  Future changePassword({
    String? currentPassword,
    String? newPassword,
  }) async {
    var result = null;
    setBusy(true);
    if (currentPassword != null && newPassword != null) {
      result = await _authService.changePassword(currentPassword, newPassword);
    }
    setBusy(false);
    if (result != null) {
      await _dialogService.showDialog(title: "Success", description : "Password Updated");
    }
  }
}