import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset('assets/images/pharmmatch_logo.png'),
            ),
            // 팜매치 로고
            Positioned(
              top: 400,
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 310,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              key: const ValueKey(1),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return '유효한 이메일 주소를 입력해주세요';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userEmail = value!;
                              },
                              onChanged: (value) {
                                userEmail = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                hintText: 'Email',
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              obscureText: true,
                              key: const ValueKey(2),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return '비밀번호를 6자리 이상 입력해주세요';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userPassword = value!;
                              },
                              onChanged: (value) {
                                userPassword = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                hintText: 'Password',
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                _tryValidation();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                minimumSize: const Size(500, 50),
                              ),
                              child: const Text(
                                '이메일로 로그인',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                _tryValidation();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                minimumSize: const Size(500, 50),
                              ),
                              child: const Text(
                                '회원가입',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // 텍스트 폼 필드 + 버튼
            Positioned(
              top: MediaQuery.of(context).size.height - 140,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(300, 50),
                    ),
                    onPressed: () => signInWithGoogle(),
                    child: const Text('Signup with Google'),
                  ),
                  // 로그인 버튼
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(300, 50),
                    ),
                    onPressed: () {},
                    child: const Text('Signup with Apple'),
                  )
                  // 회원가입 버튼
                ],
              ),
            ),
            // 소셜 로그인 버튼
          ],
        ),
      ),
    );
  }
}
