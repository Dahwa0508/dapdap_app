import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(authProvider);
      } else {
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
      print("✅ 로그인 성공: ${FirebaseAuth.instance.currentUser?.email}");
    } catch (e) {
      print("🔥 로그인 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green.shade900),
      borderRadius: BorderRadius.circular(8),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "로그인",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text(
                      "질문할곳 없어 답답할땐",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Dap&Dap",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  hintText: "아이디 또는 이메일 주소 입력",
                  filled: true,
                  fillColor: Colors.pink.shade50,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "비밀번호 입력",
                  filled: true,
                  fillColor: Colors.pink.shade50,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade900, Colors.pink.shade100],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 일반 로그인 로직 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text("로그인"),
                ),
              ),
              const SizedBox(height: 30),
              Divider(color: Colors.green.shade900),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "또는",
                  style: TextStyle(color: Colors.green.shade900),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'image/google.png',
                      height: 40,
                    ),
                    onPressed: signInWithGoogle,
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline, color: Colors.green.shade900, size: 40),
                    onPressed: () {
                      // TODO: 카카오톡 등 다른 로그인 연동 (필요 시)
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.email_outlined, color: Colors.green.shade900, size: 40),
                    onPressed: () {
                      // TODO: 이메일 로그인 등 다른 로그인 연동 (필요 시)
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green.shade900,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
