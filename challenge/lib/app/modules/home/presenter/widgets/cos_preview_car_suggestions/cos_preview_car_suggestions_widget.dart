import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:flutter/material.dart';

class CosPreviewCarSuggestionsWidget extends StatelessWidget {
  const CosPreviewCarSuggestionsWidget({
    super.key,
    required this.suggestions,
  });

  final List<CarAdditionalInfo> suggestions;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        elevation: 4.0,
        child: SizedBox(
          height: 200.0,
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: suggestions.length,
            itemBuilder: (BuildContext context, int index) {
              final car = suggestions[index];

              return GestureDetector(
                onTap: () {
                  print(car.externalId);
                  // onSelected(option);
                },
                child: ListTile(
                  title: Text(
                    "${car.externalId} - ${car.make} - ${car.similarity}",
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
