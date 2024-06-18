import 'package:flutter/material.dart';
import 'package:pharmmatch_app/models/drug_info.dart';
import 'package:pharmmatch_app/const/colors.dart';
import 'package:pharmmatch_app/screens/match_screen.dart';

class DrugContainer extends StatelessWidget {
  const DrugContainer({
    required this.drug,
    super.key,
  });

  final DrugInfo drug;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Add padding
      child: ListTile(
        leading: const Icon(Icons.image),
        title: Text(
          drug.drugName!, // Ensure drug name is not null
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          drug.entName!, // Display category as subtitle
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(50, 30),
            foregroundColor: Colors.black,
            backgroundColor: ORANGE_COLOR.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MatchPage(drug)),
            );
          },
          child: const Text('선택'),
        ),
      ),
    );
  }
}
