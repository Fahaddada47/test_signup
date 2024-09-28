import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Google Sign-In
Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // User canceled the sign-in process
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

// Facebook Sign-In
// Future<User?> signInWithFacebook() async {
//   try {
//     final LoginResult result = await FacebookAuth.instance.login();
//     if (result.status == LoginStatus.success) {
//       final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
//       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//       return userCredential.user;
//     }
//     return null;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

// Sign Out
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  await FacebookAuth.instance.logOut();
}
