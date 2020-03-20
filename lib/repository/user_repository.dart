import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karbarab/features/auth/model/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    var displayName = '';
    final currentDisplayName = (await _firebaseAuth.currentUser()).displayName;
    displayName = currentDisplayName;
    if (currentDisplayName.split(' ').isNotEmpty) {
      displayName =
          (await _firebaseAuth.currentUser()).displayName.split(' ')[0];
    }
    return displayName;
  }

  Future<UserModel> getUserMeta() async {
    final user = await _firebaseAuth.currentUser();
    return UserModel(
      id: user.uid,
      email: user.email,
      name: user.displayName.split(' ')[0],
      fullname: user.displayName,
      avatar: user.photoUrl,
    );
  }

  Future<String> getUserFullname() async {
    var displayName = '';
    final currentDisplayName = (await _firebaseAuth.currentUser()).displayName;
    displayName = currentDisplayName;
    if (currentDisplayName.split(' ').isNotEmpty) {
      displayName = (await _firebaseAuth.currentUser()).displayName;
    }
    return displayName;
  }

  Future<String> getAvatar() async {
    return (await _firebaseAuth.currentUser()).photoUrl;
  }

  Future<String> getEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}
