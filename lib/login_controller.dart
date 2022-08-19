import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var _zgoogleSignin = GoogleSignIn();
  var zgoogleAccount = Rx<GoogleSignInAccount?>(null);
  bool isS = false;

  googleLogin() async {
    zgoogleAccount.value = await _zgoogleSignin.signIn();

    //print('HI $zgoogleAccount');
  }

  googleLogout() async {
    zgoogleAccount.value = await _zgoogleSignin.signOut();
  }

  isSigned() async {
    if (_zgoogleSignin.isSignedIn() == true) {
      isS = true;
      return isS;
    } else {
      isS = false;
      return isS;
    }
  }
}
