import 'package:flutter/material.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for image
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer for title
                Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                
                const SizedBox(height: 8),
                
                // Shimmer for source and date
                Row(
                  children: [
                    Container(
                      height: 14,
                      width: 80,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 14,
                      width: 5,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 14,
                      width: 80,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Shimmer for description
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                
                const SizedBox(height: 4),
                
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                
                const SizedBox(height: 4),
                
                Container(
                  height: 14,
                  width: 150,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}