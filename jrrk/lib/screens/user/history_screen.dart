import 'package:flutter/material.dart';
import 'package:jrrk/core/empty_box.dart';
import 'package:jrrk/core/eco_background.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: EcoScanTheme.charcoal,
                ),
              ),
              SizedBox(height: 18),
              EmptyStatePanel(label: 'History records will appear here once connected to live data'),
            ],
          ),
        ),
      ),
    );
  }
}
