import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final CollectionReference _usersCollection =
      Firestore.instance.collection('users');

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<void> saveUserToLocal(UserModel user) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(USER_ID_PREFERENCES, user.id);
    await prefs.setString(USER_FCMTOKEN_PREFERENCES, user.tokenFCM);
    await prefs.setString(USER_NAME_PREFERENCES, user.username);
    await prefs.setString(USER_AVATAR_PREFERENCES, user.avatar);
    await prefs.setBool(USER_IS_GOOGLEAUTH, user.isGoogleAuth);
    await prefs.setString(USER_MAIL_PREFERENCES, user.email);
    await prefs.setString(USER_FULLNAME_PREFERENCES, user.fullname);
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

  Future<UserModel> updateUserWithGoogle(String username) async {
    final updateData = _usersCollection.document(username).updateData;
    final email = await getEmailFirebase();
    final avatar = await getAvatarFirebase();
    final displayName = (await _firebaseAuth.currentUser()).displayName;
    final id = await getUserId();
    final tokenFCM = await getUserTokenFCM();
    final UserModel userData = UserModel(
      id: id,
      username: username,
      isGoogleAuth: true,
      tokenFCM: tokenFCM,
      avatar: avatar,
      email: email,
      fullname: displayName,
    );
    await updateData(userData.toJson());
    return userData;
  }

  Future<void> saveUser({
    @required String username,
    @required bool isGoogleAuth,
  }) async {
    final save = _usersCollection.document(username).setData;
    final tokenFCM = await _firebaseMessaging.getToken();
    final id = Uuid().v4();
    if (isGoogleAuth) {
      final email = await getEmailFirebase();
      final avatar = await getAvatarFirebase();
      final displayName = (await _firebaseAuth.currentUser()).displayName;
      final UserModel userData = UserModel(
        id: id,
        username: username,
        isGoogleAuth: isGoogleAuth,
        tokenFCM: tokenFCM,
        avatar: avatar,
        email: email,
        fullname: displayName,
      );
      await save(userData.toJson());
      return saveUserToLocal(userData);
    }
    final UserModel userData = UserModel(
      id: id,
      username: username,
      isGoogleAuth: isGoogleAuth,
      tokenFCM: tokenFCM,
    );
    await save(userData.toJson());
    return saveUserToLocal(userData);
  }

  Future<DocumentSnapshot> getUserFromUsername(username) {
    return _usersCollection.document(username).get();
  }

  Future<Iterable<DocumentSnapshot>> getUserFromEmail(String email) async {
    final QuerySnapshot user = await _usersCollection
        .where('isGoogleAuth', isEqualTo: true)
        .where('email', isEqualTo: email)
        .getDocuments();

    return user.documents;
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
    await prefs.remove(USER_ID_PREFERENCES);
    await prefs.remove(USER_FCMTOKEN_PREFERENCES);
    await prefs.remove(USER_NAME_PREFERENCES);
    await prefs.remove(USER_AVATAR_PREFERENCES);
    await prefs.remove(USER_IS_GOOGLEAUTH);
    await prefs.remove(USER_MAIL_PREFERENCES);
    await prefs.remove(USER_FULLNAME_PREFERENCES);
    return Future.wait([
      prefs.clear(),
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> signOutGoogleOnly() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final SharedPreferences prefs = await _prefs;
    final currentUser = prefs.getString(USER_ID_PREFERENCES);
    return currentUser != null;
  }

  Future<bool> isUserGoogleAuth() async {
    final SharedPreferences prefs = await _prefs;
    final isGoogle = prefs.getBool(USER_IS_GOOGLEAUTH);
    return isGoogle;
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

  Future<String> getUserTokenFCM() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString(USER_FCMTOKEN_PREFERENCES);
    return token;
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

  // firebase account data

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
