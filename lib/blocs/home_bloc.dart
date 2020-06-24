import 'base_bloc.dart';

import '../locator.dart';
import '../services/navigation_service.dart';
import '../services/authentication_service.dart';

import '../ui/router.dart';

class HomeBloc extends BaseBloc {
  static final _navigationService = locator<NavigationService>();
  static final _authenticationService = locator<AuthenticationService>();

  /*
   * UI 
   */
  final String _title = 'Home';
  String get title => _title;

  Future signOut() async {
    await _signOutHelper();
  }

  Future<void> navigateToAddPost() async {
    await _navigationService.navigateTo(Routes.addpost);
  }

  /*
  * Acutal Logic
   */

  Future _signOutHelper() async {
    setBusy = true;
    await _authenticationService.signOut();
    setBusy = false;
    await _navigationService.replaceWith(Routes.login);
  }
}
