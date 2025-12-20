import 'package:flutter/material.dart';
import '../storage/preferences_manager.dart';
import '../storage/hive_manager.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _selectedGender = 'Not specified';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    _nameController.text = PreferencesManager.getUserName();
    _ageController.text = PreferencesManager.getUserAge() > 0
        ? PreferencesManager.getUserAge().toString()
        : '';
    _selectedGender = PreferencesManager.getUserGender();
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    await PreferencesManager.setUserName(_nameController.text.trim());
    final age = int.tryParse(_ageController.text);
    if (age != null && age > 0) {
      await PreferencesManager.setUserAge(age);
    }
    await PreferencesManager.setUserGender(_selectedGender);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalConsultations = HiveManager.getTotalConsultations();
    final recentSymptoms = HiveManager.getRecentSymptoms(days: 30);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
        title: const Text(
          'Profile',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.primaryGradient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Image.asset(
                        'assets/images/profile.png',
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildTextField(
                    controller: _nameController,
                    label: 'Name',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _ageController,
                    label: 'Age',
                    icon: Icons.cake_outlined,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: _inputDecoration(
                      label: 'Gender',
                      icon: Icons.wc,
                    ),
                    items: ['Male', 'Female', 'Other', 'Not specified']
                        .map(
                          (g) => DropdownMenuItem(
                        value: g,
                        child: Text(g, style: const TextStyle(fontFamily: 'K2D')),
                      ),
                    )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedGender = v!),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Save Profile',
                          style: TextStyle(
                            fontFamily: 'K2D',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          _sectionTitle('Health Statistics'),

          _statTile(
            icon: Icons.medical_services,
            title: 'Total Consultations',
            value: '$totalConsultations',
          ),

          if (recentSymptoms.isNotEmpty) ...[
            const SizedBox(height: 12),
            _recentSymptomsCard(recentSymptoms),
          ],

          const SizedBox(height: 24),

          _sectionTitle('About TeleMedi'),

          _aboutCard(),
        ],
      ),
    );
  }

  // ---------- Widgets ----------

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'K2D',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _statTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontFamily: 'K2D')),
        trailing: Text(
          value,
          style: const TextStyle(
            fontFamily: 'K2D',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _recentSymptomsCard(List<String> symptoms) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.trending_up, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Recent Symptoms (Last 30 Days)',
                  style: TextStyle(
                    fontFamily: 'K2D',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: symptoms.take(10).map((s) {
                return Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Text(
                    s,
                    style: TextStyle(
                      fontFamily: 'K2D',
                      fontSize: 12,
                      color: Colors.orange[800],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Text(
              'TeleMedi v1.0.0',
              style: TextStyle(
                fontFamily: 'K2D',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Smart Healthcare. No Internet. No AI.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'K2D',
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      labelStyle: const TextStyle(fontFamily: 'K2D'),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label: label, icon: icon),
      style: const TextStyle(fontFamily: 'K2D'),
    );
  }
}
