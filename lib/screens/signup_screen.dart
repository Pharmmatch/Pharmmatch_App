import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmmatch_app/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey2 = GlobalKey<FormState>();
  String getEmail = '';
  String getPassword = '';

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: getEmail, password: getPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint('에러');
    }
  }

  Future<void> _tryValidation() async {
    final isValid = _formKey2.currentState!.validate();
    await Future.delayed(const Duration(seconds: 0));
    if (isValid) {
      _formKey2.currentState!.save();
      await Future.delayed(const Duration(seconds: 0));
      signUp();
      await Future.delayed(const Duration(seconds: 0));
      showRegisterDialog();
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(content: Text('잘못 입력하셨습니다.')));
    }
  }

  void showRegisterDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('환영합니다!'),
              content: const Text('회원가입을 완료했습니다! 확인버튼을 누르면 로그인 화면으로 돌아갑니다.'),
              actions: [
                TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('확인'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    String passwordCheck = '';
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Image.asset('assets/images/pharmmatch_logo.png',
                    width: 300, height: 300, fit: BoxFit.contain),
              ),
              // 팜매치 로고
              Positioned(
                top: 320,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 320,
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
                          key: _formKey2,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                key: const ValueKey(3),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return '유효한 이메일 주소를 입력해주세요';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  getEmail = value!;
                                },
                                onChanged: (value) {
                                  getEmail = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.grey,
                                  ),
                                  hintText: '새로운 이메일을 입력해주세요.',
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                obscureText: true,
                                key: const ValueKey(4),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return '비밀번호를 6자리 이상 입력해주세요';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  getPassword = value!;
                                },
                                onChanged: (value) {
                                  getPassword = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: '새로운 비밀번호를 입력해주세요.',
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                obscureText: true,
                                key: const ValueKey(5),
                                validator: (value) {
                                  if (value != getPassword) {
                                    return '비밀번호가 다릅니다.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: '비밀번호를 다시 한번 입력해주세요.',
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
                                  '가입하기',
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
              ), // 텍스트 폼 필드 + // 회원가입 버튼
            ],
          ),
        ),
      ), // 소셜 로그인 버튼
    );
  }
}
