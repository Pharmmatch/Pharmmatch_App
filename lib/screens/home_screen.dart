import 'package:flutter/material.dart';
import 'package:pharmmatch_app/Widgets/paged_drug_list_view.dart';
import 'package:pharmmatch_app/models/drug_info.dart';
import 'package:pharmmatch_app/screens/mypage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputText = '';
  final searchTec = TextEditingController();

  @override
  void initState() {
    // _korDrug = KorDrugRepository.getDrugs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Pharmmatch'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MyPageScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: searchTec,
                    decoration: InputDecoration(
                      hintText: '찾고 싶은 한국 약을 검색하세요',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: searchTec.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.length >= 2) {
                        setState(() {
                          inputText = value;
                        });
                      } else {
                        // 두 글자 미만의 검색어에 대한 처리
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('검색어는 최소 두 글자 이상이어야 합니다.'),
                          ),
                        );
                      }
                    },
                    // onChanged: (value) {
                    //   setState(() {
                    //     inputText = value;
                    //   });
                    // },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: PagedDrugListView(inputText: inputText)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
