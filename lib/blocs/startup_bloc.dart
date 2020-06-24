import 'package:bloc_app_template/ui/router.dart';

import 'base_bloc.dart';

import '../locator.dart';
import '../services/authentication_service.dart';
import '../services/navigation_service.dart';

class StartUpBloc extends BaseBloc {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  final String _title = 'StartUpScreen';
  String get title => _title;

  Future setUp() async {
    setBusy = true;
    var isUserIn = await _authenticationService.isUserIn();
    setBusy = false;

    if (isUserIn) {
      await _navigationService.replaceWith(Routes.home);
    } else {
      await _navigationService.replaceWith(Routes.login);
    }
  }
}
