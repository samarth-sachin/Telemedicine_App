import 'package:flutter/material.dart';
import '../data/remedies_db.dart';
import '../models/conversation_node.dart';
import '../theme/app_theme.dart';

class MedicalInsightsScreen extends StatelessWidget {
  const MedicalInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['Fever', 'Headache', 'Cough', 'Stomach', 'Body Ache'];

    final icons = {
      'Fever': Icons.thermostat,
      'Headache': Icons.psychology,
      'Cough': Icons.air,
      'Stomach': Icons.restaurant,
      'Body Ache': Icons.accessibility_new,
    };

    final colors = {
      'Fever': const Color(0xFFFF5252),
      'Headache': const Color(0xFF9C27B0),
      'Cough': const Color(0xFF2196F3),
      'Stomach': const Color(0xFFFF9800),
      'Body Ache': const Color(0xFF4CAF50),
    };

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
        title: const Text(
          'Medical Insights',
          style: TextStyle(
            fontFamily: 'K2D',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: const [
                Icon(
                  Icons.local_hospital,
                  size: 60,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  'Common Health Conditions',
                  style: TextStyle(
                    fontFamily: 'K2D',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Quick reference guide for home remedies',
                  style: TextStyle(
                    fontFamily: 'K2D',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Conditions list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildConditionCard(
                  context,
                  category,
                  icons[category]!,
                  colors[category]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionCard(
      BuildContext context,
      String category,
      IconData icon,
      Color color,
      ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryDetailScreen(category: category),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        fontFamily: 'K2D',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to view remedies and tips',
                      style: TextStyle(
                        fontFamily: 'K2D',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final remedies = RemediesDatabase.getRemediesByCategory(category);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
        title: Text(
          category,
          style: const TextStyle(
            fontFamily: 'K2D',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: remedies.isEmpty
          ? const Center(
        child: Text(
          'No remedies available for this category',
          style: TextStyle(
            fontFamily: 'K2D',
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: remedies.length,
        itemBuilder: (context, index) {
          return _buildRemedyCard(remedies[index]);
        },
      ),
    );
  }

  Widget _buildRemedyCard(Remedy remedy) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  remedy.requiresDoctorVisit
                      ? Icons.warning_amber_rounded
                      : Icons.check_circle,
                  color: remedy.requiresDoctorVisit
                      ? Colors.orange
                      : Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    remedy.title,
                    style: const TextStyle(
                      fontFamily: 'K2D',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              remedy.description,
              style: TextStyle(
                fontFamily: 'K2D',
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
