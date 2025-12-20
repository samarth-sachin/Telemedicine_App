import 'package:flutter/material.dart';
import '../models/consultation.dart';
import '../storage/hive_manager.dart';
import '../theme/app_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Consultation> _consultations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConsultations();
  }

  Future<void> _loadConsultations() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _consultations = HiveManager.getAllConsultations();
      _isLoading = false;
    });
  }

  Future<void> _deleteConsultation(String id) async {
    await HiveManager.deleteConsultation(id);
    _loadConsultations();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Consultation deleted'),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _clearAllHistory() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear All History?'),
        content: const Text(
          'This will permanently delete all consultation history.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await HiveManager.clearAllConsultations();
              Navigator.pop(context);
              _loadConsultations();
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
        title: const Text('History'),
        actions: [
          if (_consultations.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: _clearAllHistory,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _consultations.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
        onRefresh: _loadConsultations,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _consultations.length,
          itemBuilder: (context, index) {
            return _buildConsultationCard(
              _consultations[index],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.history, size: 96, color: Color(0xFFBDBDBD)),
          SizedBox(height: 20),
          Text(
            'No Consultation History',
            style: TextStyle(
              fontFamily: 'K2D',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Saved consultations will appear here',
            style: TextStyle(
              fontFamily: 'K2D',
              fontSize: 14,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationCard(Consultation consultation) {
    final Color severityColor =
    consultation.severity == 'severe'
        ? Colors.red
        : consultation.severity == 'moderate'
        ? Colors.orange
        : Colors.green;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 1.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date row
              Row(
                children: [
                  const Icon(Icons.event, size: 16, color: AppTheme.primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    consultation.getFormattedDate(),
                    style: const TextStyle(
                      fontFamily: 'K2D',
                      color: Color(0xFF616161),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.access_time,
                      size: 16, color: AppTheme.primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    consultation.getFormattedTime(),
                    style: const TextStyle(
                      fontFamily: 'K2D',
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Severity
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: severityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: severityColor),
                ),
                child: Text(
                  consultation.severity.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'K2D',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: severityColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
