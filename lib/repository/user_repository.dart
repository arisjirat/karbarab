import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:password/password.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final CollectionReference _usersCollection =
      Firestore.instance.collection('users');

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

  Future<void> saveUser({
    @required String id,
    @required String username,
    @required bool isGoogleAuth,
    @required String tokenFCM,
    String password,
  }) async {
    if (isGoogleAuth) {
      final email = (await _firebaseAuth.currentUser()).email;
      final avatar = (await _firebaseAuth.currentUser()).photoUrl;
      final displayName = (await _firebaseAuth.currentUser()).displayName;
      return _usersCollection.document(username).setData(
        UserModel(
          id: id,
          username: username,
          isGoogleAuth: isGoogleAuth,
          tokenFCM: tokenFCM,
          avatar: avatar,
          email: email,
          name: displayName..split(' ')[0],
          fullname: displayName,
        ).toJson(),
      );
    }
    // either signup with username password
    final passwordHash = Password.hash(password, PBKDF2());
    return _usersCollection.document(username).setData(
          UserModel(
            id: id,
            username: username,
            isGoogleAuth: isGoogleAuth,
            tokenFCM: tokenFCM,
            password: passwordHash,
          ).toJson(),
        );
  }

  Future<DocumentSnapshot> getUserFromUsername(username) {
    return _usersCollection.document(username).get();
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
    final email = (await _firebaseAuth.currentUser()).email.split('@')[0];
    final userCollection = await getUserFromUsername(email);
    return UserModel(
      id: userCollection['uid'],
      username: userCollection['username'],
      tokenFCM: userCollection['tokenFCM'],
      isGoogleAuth: userCollection['isGoogleAuth'],
      email: userCollection['email'],
      name: userCollection['name'],
      fullname: userCollection['displayName'],
      avatar: userCollection['photoUrl'],
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
