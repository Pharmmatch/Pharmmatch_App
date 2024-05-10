import 'package:flutter/material.dart';

class TermsofuseScreen extends StatefulWidget {
  const TermsofuseScreen({super.key});

  @override
  State<TermsofuseScreen> createState() => _TermsofuseScreenState();
}

class _TermsofuseScreenState extends State<TermsofuseScreen> {

  @override
  Widget build(BuildContext context) {
    bool checkboxvalue1 = false;
    bool checkboxvalue2 = false;
    bool checkboxvalue3 = false;
    bool checkboxvalue4 = false;

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
              body: Column(
                  children: [
                    const SizedBox(
                      height: 30
                    ),

                    Container(
                      child: Image.asset('assets/images/pharmmatch_logo.png',
                          width: 300,
                          height: 300,
                          fit: BoxFit.contain
                      ),
                    ),

                    const SizedBox(
                      height: 10
                    ),

                    Container(
                      width: 1000,
                      child: Text(
                        '이용약관',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left
                      ),
                    ),

                    CheckboxListTile(
                      value: checkboxvalue1,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxvalue1 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('모두 동의'),
                    ),

                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('이용약관 동의(필수)'),
                      value: checkboxvalue2,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxvalue2 = value!;
                        });
                      },
                      subtitle: !checkboxvalue2
                          ? Text(
                        '필수 선택사항입니다.',
                        style: TextStyle(color: Colors.red),
                      ) : null,
                    ),

                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('개인정보 수집 및 이용 동의(필수)'),
                      value: checkboxvalue3,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxvalue3 = value!;
                        });
                      },
                      subtitle: !checkboxvalue3
                          ? Text(
                        '필수 선택사항입니다.',
                        style: TextStyle(color: Colors.red),
                      ) : null,
                    ),

                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('광고성 정보 수신 동의(선택)'),
                      value: checkboxvalue4,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxvalue4 = value!;
                        });
                      },
                    ),
                  ]
              )
          );
        }
    );
  }
}