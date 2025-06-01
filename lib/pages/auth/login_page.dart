import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // ✅ 웹 환경 로그인 처리
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(authProvider);
      } else {
        // ✅ Android / iOS 로그인 처리
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          print("❌ 사용자가 로그인 취소함");
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }

      // ✅ 공통 성공 처리
      print("✅ 로그인 성공: ${FirebaseAuth.instance.currentUser?.email}");
    } catch (e) {
      print("🔥 로그인 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google 로그인")),
      body: Center(
        child: ElevatedButton.icon(
          icon: Image.asset(
            'image/google.png',
            height: 24,
          ),
          label: Text("구글로 로그인"),
          onPressed: signInWithGoogle,
        ),
      ),
    );
  }
}
