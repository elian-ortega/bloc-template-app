import 'package:bloc_app_template/models/post.dart';
import 'package:bloc_app_template/services/firestore_service.dart';

import 'base_bloc.dart';

import '../locator.dart';
import '../services/navigation_service.dart';
import '../services/authentication_service.dart';

import '../ui/router.dart';

class HomeBloc extends BaseBloc {
  static final _navigationService = locator<NavigationService>();
  static final _authenticationService = locator<AuthenticationService>();
  static final _firestoreService = locator<FirestoreService>();

  /*
   * UI 
   */

  List<Post> _posts;
  List<Post> get posts => _posts;

  final String _title = 'Home';
  String get title => _title;

  Future signOut() async {
    await _signOutHelper();
  }

  Future<void> navigateToAddPost() async {
    await _navigationService.navigateTo(Routes.addpost);
  }

  Stream get postsStream => _firestoreService.listenToPost();

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
