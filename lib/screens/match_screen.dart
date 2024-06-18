import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmmatch_app/const/colors.dart';
import 'package:pharmmatch_app/models/drug_info.dart';
import 'package:pharmmatch_app/const/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pharmmatch_app/models/us_drug.dart';
import 'package:pharmmatch_app/screens/mypage_screen.dart';

class MatchPage extends StatefulWidget {
  final DrugInfo drug;
  const MatchPage(this.drug, {super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late Future<List<USDrug>> _futureMatch;

  @override
  void initState() {
    super.initState();
    _futureMatch = fetchMatchData(widget.drug.drugID);
  }

  Future<List<USDrug>> fetchMatchData(int? drugID) async {
    final response =
        await http.get(Uri.parse('$localUrl/match_drug?drugid=$drugID'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<USDrug> matchlist =
          jsonResponse.map((json) => USDrug.fromJson(json)).toList();
      return matchlist;
    } else {
      throw Exception('Failed to load match data');
    }
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: PURPLE_COLOR, borderRadius: BorderRadius.circular(15)),
              child: Center(child: Text('검색하신 ${widget.drug.drugName} 매칭결과')),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<USDrug>>(
                future: _futureMatch,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<USDrug> matchlist = snapshot.data!;
                    return ListView.builder(
                      itemCount: matchlist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(matchlist[index].name!),
                          subtitle:
                              Text('유사도: ${matchlist[index].sim!.toString()}%'),
                          // You can customize how each list item appears here
                          // e.g., add icons, additional text, etc.
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  // By default, show a loading spinner
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
