import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  // Create user profile in Firestore
  Future<void> createUserProfile(UserModel user) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.id)
          .set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user profile: ${e.toString()}');
    }
  }

  // Get user profile
  Future<UserModel?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();
      
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  // Update user language
  Future<void> updateUserLanguage(String userId, String language) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .update({'language': language});
    } catch (e) {
      throw Exception('Failed to update language: ${e.toString()}');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send reset email: ${e.toString()}');
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);
      
      // Check if user profile exists, if not create one
      final userProfile = await getUserProfile(userCredential.user!.uid);
      if (userProfile == null && userCredential.user != null) {
        // Create a basic user profile for Google sign-in
        final newUser = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? '',
          phone: userCredential.user!.phoneNumber ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          userType: '', // User will need to select this later
          isVerified: false,
          createdAt: DateTime.now(),
          language: 'en',
        );
        await createUserProfile(newUser);
      }

      return userCredential;
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection(AppConstants.usersCollection).doc(user.uid).delete();
        await user.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete account: ${e.toString()}');
    }
  }
}
