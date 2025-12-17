import 'package:flutter/material.dart';
import '../data/remedies_db.dart';
import '../models/conversation_node.dart';

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
      'Fever': Color(0xFFFF5252),
      'Headache': Color(0xFF9C27B0),
      'Cough': Color(0xFF2196F3),
      'Stomach': Color(0xFFFF9800),
      'Body Ache': Color(0xFF4CAF50),
    };

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2196F3),
        title: Text(
          'Medical Insights',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xFF2196F3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.local_hospital,
                  size: 60,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  'Common Health Conditions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Quick reference guide for home remedies',
                  style: TextStyle(
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
              padding: EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
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
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailScreen(category: category),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
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
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap to view remedies and tips',
                      style: TextStyle(
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
    List<Remedy> remedies = RemediesDatabase.getRemediesByCategory(category);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2196F3),
        title: Text(
          category,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: remedies.isEmpty
          ? Center(
              child: Text(
                'No remedies available for this category',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: remedies.length,
              itemBuilder: (context, index) {
                return _buildRemedyCard(context, remedies[index]);
              },
            ),
    );
  }

  Widget _buildRemedyCard(BuildContext context, Remedy remedy) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
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
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    remedy.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Description
            Text(
              remedy.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 16),
            // Home Remedies
            Text(
              '🏠 Home Remedies:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            ...remedy.homeRemedies.map((r) => Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          r,
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                )),
            // Warnings
            if (remedy.warnings.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                '⚠️ Important:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
              SizedBox(height: 8),
              ...remedy.warnings.map((warning) => Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: Text(
                            warning,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[800],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
            // Doctor visit badge
            if (remedy.requiresDoctorVisit) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_hospital, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Doctor Consultation Recommended',
                      style: TextStyle(
                        color: Colors.red[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
