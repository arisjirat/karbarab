import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:password/password.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_ID_PREFERENCES = 'users_id';
const USER_FCMTOKEN_PREFERENCES = 'users_fcmtoken';
const USER_NAME_PREFERENCES = 'username';
const USER_AVATAR_PREFERENCES = 'user_avatar_fcmtoken';
const USER_IS_GOOGLEAUTH = 'user_is_googleauth';
const USER_MAIL_PREFERENCES = 'user_mail_preferences';
const USER_FULLNAME_PREFERENCES = 'user_fullname_preferences';

class UserRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final CollectionReference _usersCollection =
      Firestore.instance.collection('users');

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<void> saveUserToLocal(
      String id,
      String fcmtoken,
      String username,
      bool isGoogleAuth,
      {
        String avatar,
        String email,
        String fullname,
      }
    ) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(USER_ID_PREFERENCES, id);
    await prefs.setString(USER_FCMTOKEN_PREFERENCES, fcmtoken);
    await prefs.setString(USER_NAME_PREFERENCES, username);
    await prefs.setString(USER_AVATAR_PREFERENCES, avatar);
    await prefs.setBool(USER_IS_GOOGLEAUTH, isGoogleAuth);
    await prefs.setString(USER_MAIL_PREFERENCES, email);
    await prefs.setString(USER_FULLNAME_PREFERENCES, fullname);
  }

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
      final email = await getEmailFirebase();
      final avatar = await getAvatarFirebase();
      final displayName = (await _firebaseAuth.currentUser()).displayName;
      return await _usersCollection.document(username).setData(
            UserModel(
              id: id,
              username: username,
              isGoogleAuth: isGoogleAuth,
              tokenFCM: tokenFCM,
              avatar: avatar,
              email: email,
              fullname: displayName,
            ).toJson(),
          );
    }
    // either signup with username password
    final passwordHash = Password.hash(password, PBKDF2());
    return await _usersCollection.document(username).setData(
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
    final SharedPreferences prefs = await _prefs;
    prefs.remove(USER_ID_PREFERENCES);
    prefs.remove(USER_FCMTOKEN_PREFERENCES);
    prefs.remove(USER_NAME_PREFERENCES);
    prefs.remove(USER_AVATAR_PREFERENCES);
    prefs.remove(USER_IS_GOOGLEAUTH);
    prefs.remove(USER_MAIL_PREFERENCES);
    prefs.remove(USER_FULLNAME_PREFERENCES);
    return Future.wait([
      prefs.clear(),
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final SharedPreferences prefs = await _prefs;
    final currentUser = prefs.getString(USER_ID_PREFERENCES);
    return currentUser != null;
  }

  Future<String> getUser() async {
    final SharedPreferences prefs = await _prefs;
    final username = prefs.getString(USER_NAME_PREFERENCES);
    return username;
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    final userId = prefs.getString(USER_ID_PREFERENCES);
    return userId;
  }

  Future<UserModel> getUserMeta() async {
    final SharedPreferences prefs = await _prefs;
    final String id = prefs.getString(USER_ID_PREFERENCES);
    final String fcmtoken = prefs.getString(USER_FCMTOKEN_PREFERENCES);
    final String username = prefs.getString(USER_NAME_PREFERENCES);
    final String avatar = prefs.getString(USER_AVATAR_PREFERENCES);
    final bool isGoogleAuth = prefs.getBool(USER_IS_GOOGLEAUTH);
    final String email = prefs.getString(USER_MAIL_PREFERENCES);
    final String fullname = prefs.getString(USER_FULLNAME_PREFERENCES);
    return UserModel(
      id: id,
      username: username,
      tokenFCM: fcmtoken,
      isGoogleAuth: isGoogleAuth,
      email: email,
      fullname: fullname,
      avatar: avatar,
    );
  }

  Future<String> getUserFullname() async {
    final SharedPreferences prefs = await _prefs;
    final String fullname = prefs.getString(USER_FULLNAME_PREFERENCES);
    return fullname;
  }

  Future<String> getAvatar() async {
    final SharedPreferences prefs = await _prefs;
    final String avatar = prefs.getString(USER_AVATAR_PREFERENCES);
    return avatar;
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await _prefs;
    final String email = prefs.getString(USER_AVATAR_PREFERENCES);
    return email;
  }

  Future<String> getEmailFirebase() async {
    final email = (await _firebaseAuth.currentUser()).email;
    return email;
  }

  Future<String> getFullnameFirebase() async {
    final email = (await _firebaseAuth.currentUser()).displayName;
    return email;
  }

  Future<String> getAvatarFirebase() async {
    final avatar = (await _firebaseAuth.currentUser()).photoUrl;
    return avatar;
  }
}
