import 'package:bloc_app_template/blocs/base_bloc.dart';
import 'package:bloc_app_template/services/navigation_service.dart';
import 'package:bloc_app_template/ui/router.dart';
import '../locator.dart';

class LogInBloc extends BaseBloc {
  final _navigationService = locator<NavigationService>();

  /*
   * UI
   */
  final String _title = 'LogIn';
  String get title => _title;
  void navigateToSignUp() {
    _navigationService.replaceWith(Routes.signup);
  }

  /*
  * Actual Logic 
  */
}
