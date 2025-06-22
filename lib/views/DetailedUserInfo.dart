import 'package:crunsee/Backend.dart';
import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/CustomWidgets/customDrawer.dart';
import 'package:crunsee/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detaileduserinfo extends StatefulWidget {
  const Detaileduserinfo({super.key});

  @override
  State<Detaileduserinfo> createState() => _DetailedUserInfoState();
}

class _DetailedUserInfoState extends State<Detaileduserinfo> {
  final TextEditingController username = TextEditingController();
  final TextEditingController age = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    Backend backend = Backend();
    CustomDrawer customDrawer = CustomDrawer();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Customappbar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A00E0), // Example purple
              Color(0xFF8E2DE2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('lib/images/logo.png',  height: 150), // Local asset path
                const SizedBox(height: 24),

                // Username TextField
                TextField(
                  controller: username,
                  decoration: _buildInputDecoration('Username'),
                ),
                const SizedBox(height: 16),

                // Age TextField
                TextField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration('age'),
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  hint: const Text("Select Gender"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Save Button
                ElevatedButton(
                  onPressed: () async {
                    backend.insertUserData(
                      username.text.trim(),
                      age.text.trim(),
                      selectedGender ?? 'Not specified',
                      'assets/images/default_img.png', // Placeholder image URL
                    );
                    await backend.getLoggedInUserData();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    minimumSize: const Size(150, 60),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Save Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white10,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.lightBlueAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
