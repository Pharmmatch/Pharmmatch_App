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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
              body: SingleChildScrollView(
                child: Column(
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

                      const Row (
                        children: [
                          SizedBox(
                            width: 20
                          ),
                          Text(
                          '이용약관',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left
                          ),
                        ]
                      ),

                      CheckboxListTile(
                        value: checkboxvalue1,
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxvalue1 = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('모두 동의하기'),
                      ),

                      Divider(
                          height: 3,
                          color: Colors.black
                      ),

                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: ExpansionTile(
                            title: new Text('이용약관 동의(필수)',
                            ),
                            initiallyExpanded: false,
                            shape: InputBorder.none,
                            children: <Widget>[
                              Text(
                                  '(이용약관 세부사항을 입력해주세요.)'
                              )

                            ],
                            subtitle: !checkboxvalue2
                            ? Text(
                            '필수 선택사항입니다.',
                            style: TextStyle(color: Colors.red),
                            ) : null,
                        ),
                        value: checkboxvalue2,
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxvalue2 = value!;
                          });
                        },
                      ),

                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: ExpansionTile(
                          title: new Text('개인정보 수집 및 이용 동의(필수)',
                          ),
                          initiallyExpanded: false,
                          shape: InputBorder.none,
                          children: <Widget>[
                            Text(
                                '(개인정보 수집 및 이용 세부사항을 입력해주세요.)'
                            )

                          ],
                          subtitle: !checkboxvalue2
                              ? Text(
                            '필수 선택사항입니다.',
                            style: TextStyle(color: Colors.red),
                          ) : null,
                        ),
                        value: checkboxvalue3,
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxvalue3 = value!;
                          });
                        },
                      ),

                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: ExpansionTile(
                          title: new Text('광고성 정보 수신 동의(선택)',
                          ),
                          initiallyExpanded: false,
                          shape: InputBorder.none,
                          children: <Widget>[
                            Text(
                                '(이용약관 세부사항을 입력해주세요.)'
                            )

                          ],
                        ),
                        value: checkboxvalue4,
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxvalue4 = value!;
                          });
                        },
                      ),
                    ]
                )
              )
          );
        }
    );
  }
}