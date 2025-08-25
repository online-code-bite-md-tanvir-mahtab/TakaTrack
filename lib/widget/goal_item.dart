import 'package:flutter/material.dart';

class GoalItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final double progress;
  final String progressText;

  const GoalItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.progress,
    required this.progressText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
      child: Row(
        children: [
          // Icon with a rounded background
          Container(
            padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.grey[800],
              size: screenWidth * 0.06, // Responsive icon size
            ),
          ),
          const SizedBox(width: 16),

          // Goal title and amount (Flexible so it wraps nicely)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // Responsive text
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212529),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Progress bar and percentage text
          SizedBox(
            width: screenWidth * 0.25, // Scales with screen size
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            progressText,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
