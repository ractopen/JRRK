import 'package:flutter/material.dart';
import 'package:jrrk/core/empty_box.dart';
import 'package:jrrk/core/eco_background.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Performance Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: EcoScanTheme.charcoal,
                ),
              ),
              SizedBox(height: 18),
              EmptyStatePanel(label: 'Analytics charts and insights will be rendered here'),
            ],
          ),
        ),
      ),
    );
  }
}
