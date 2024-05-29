import 'package:flutter/material.dart';
import 'package:pharmmatch_app/models/drug_info.dart';

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
        trailing: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
