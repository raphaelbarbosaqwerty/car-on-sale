import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/core/widgets/cos_snack_bar/cos_snack_bar_error_widget.dart';
import 'package:challenge/app/core/widgets/cos_snack_bar/cos_snack_bar_success_widget.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:flutter/material.dart';

class ShowCarPage extends StatefulWidget {
  const ShowCarPage({
    super.key,
    required this.carInformation,
  });

  final CarInformation carInformation;

  @override
  State<ShowCarPage> createState() => _ShowCarPageState();
}

class _ShowCarPageState extends State<ShowCarPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auction"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                enabled: false,
                initialValue: widget.carInformation.formatedPrice(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Model",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                enabled: false,
                initialValue: widget.carInformation.model,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Auction ID",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                enabled: false,
                initialValue: widget.carInformation.fkUuidAuction,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('check_feedback'),
        backgroundColor:
            _hasPositiveFeedBack() ? CosTheme.greenAlert : CosTheme.redAlert,
        // elevation: ,
        onPressed: () async {
          if (widget.carInformation.positiveCustomerFeedback) {
            ScaffoldMessenger.of(context).showSnackBar(
              CosSnackBarSuccessWidget(
                key: const Key('snack_bar'),
                content: Text(widget.carInformation.feedback),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              CosSnackBarErrorWidget(
                key: const Key('snack_bar'),
                content: Text(widget.carInformation.feedback),
              ),
            );
          }
        },
        child: Icon(
          _hasPositiveFeedBack() ? Icons.thumb_up : Icons.thumb_down,
        ),
      ),
    );
  }

  bool _hasPositiveFeedBack() {
    return widget.carInformation.positiveCustomerFeedback;
  }
}
