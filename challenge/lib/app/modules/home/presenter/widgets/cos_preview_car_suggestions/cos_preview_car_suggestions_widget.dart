import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/widgets/cos_snack_bar/cos_snack_bar_success_widget.dart';
import 'package:flutter/material.dart';

class CosPreviewCarSuggestionsWidget extends StatelessWidget {
  const CosPreviewCarSuggestionsWidget({
    super.key,
    required this.suggestions,
  });

  final List<CarAdditionalInfo> suggestions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Text("Suggestions"),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          height: 250,
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final car = suggestions[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const CosSnackBarSuccessWidget(
                      key: Key('snack_bar'),
                      content: Text("Looking for aunctions.."),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    "Model: ${car.model} - Similarity: ${car.similarity}",
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
