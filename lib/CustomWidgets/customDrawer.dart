// 📁 lib/widgets/CustomDrawer.dart
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunsee/Backend.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Backend backend = Backend();

  XFile? _imgFile; // holds the picked image (works on mobile & web)
  String? imgurl; // stores the uploaded image URL
  bool showEditProfile = false;
  bool showAppSettings = false;
  Uint8List? _webImageBytes;
  File? _pickedImage;
  String _usermail = "Loading..."; // Added definition for _usermail
  String _userName = "Loading...";
  

  Future<void> filePick(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() => _imgFile = picked);
      print(_imgFile);
    } else {
      debugPrint("No file selected");
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> uploadImage() async {
    if (_imgFile == null) return;

    final uri = Uri.parse(
        "https://api.cloudinary.com/v1_1/dpojvsnbt/upload"); //cloud name is going to be changed "dgaxecabl"
    final req = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] =
          'Crunsee'; //preset should be changed "flutterapp" and it should be unsigned

    // Read the file bytes (works on all platforms)
    final bytes = await _imgFile!.readAsBytes();
    final filename = path.basename(_imgFile!.path);

    // Attach the file using bytes
    req.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: filename,
      ),
    );

    // Send request
    final res = await req.send();
    if (res.statusCode == 200) {
      // Parse response JSON
      final resString = await res.stream.bytesToString();
      final jsonMap = jsonDecode(resString);
      // Cloudinary returns the secure URL under 'secure_url'
      final secureUrl =
          jsonMap['secure_url'] as String?; //this code is giving is file link

      setState(() => imgurl = secureUrl);
      debugPrint("Upload successful: $imgurl");
    } else {
      debugPrint("Upload failed: ${res.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // loadNameFromPrefs();
    // loadImageFromPrefs();
  }

  // Future<void> loadNameFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedName = prefs.getString('userName');
  //   if (savedName != null) {
  //     setState(() {
  //       _updatedName = savedName;
  //       _nameController.text = savedName;
  //     });
  //   } else {
  //     _nameController.text = _updatedName;
  //   }
  // }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      setState(() {
        _userName = doc['Username'] ?? "No Name";
        _usermail = user.email ?? "No Email";
        imgurl = doc['imgurl'];
      });
    }
  }

  // Future<void> saveChanges() async {
  //   final newName = _nameController.text.trim();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userName', newName);
  //   setState(() {
  //     _updatedName = newName;
  //     showEditProfile = false;
  //   });
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //         content: Text('Name updated to $newName'),
  //         backgroundColor: Colors.green),
  //   );
  // }

  // Future<void> pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     if (kIsWeb) {
  //       final bytes = await pickedFile.readAsBytes();
  //       final base64String = base64Encode(bytes);
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('profileImage', base64String);
  //       setState(() {
  //         _webImageBytes = bytes;
  //         _pickedImage = null;
  //       });
  //     } else {
  //       setState(() {
  //         _pickedImage = File(pickedFile.path);
  //       });
  //     }
  //   }
  // }

  // Future<void> loadImageFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final base64String = prefs.getString('profileImage');
  //   if (base64String != null) {
  //     final bytes = base64Decode(base64String);
  //     setState(() {
  //       _webImageBytes = bytes;
  //     });
  //   }
  // }

  Future<void> changePassword() async {
    String current = _currentPasswordController.text.trim();
    String newPass = _newPasswordController.text.trim();
    String confirm = _confirmPasswordController.text.trim();
    

    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("New password and confirm password do not match")),
      );
      return;
    }

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all password fields")),
      );
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential cred =
          EmailAuthProvider.credential(email: user!.email!, password: current);
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPass);
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900] : Colors.white;
    final tileColor = isDark ? Colors.grey[800] : Colors.grey[100];
    final textColor = isDark ? Colors.white : Colors.black87;

    return Drawer(
      child: Container(
        color: bgColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage:  imgurl!.isNotEmpty
                    ? NetworkImage(imgurl!)
                    : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider<Object>,
              ),
              accountName: Text(_userName),
              accountEmail:
                  Text(_usermail), // You can also fetch this if you want
            ),
            ListTile(
              leading: Icon(Icons.edit, color: textColor),
              title: Text("Edit Profile", style: TextStyle(color: textColor)),
              onTap: () {
                setState(() {
                  showEditProfile = !showEditProfile;
                  showAppSettings = false;
                });
              },
            ),
            if (showEditProfile)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _buildTextField(
                        _nameController, "Change Name", Icons.person),
                    const SizedBox(height: 10),
                    _buildTextField(_currentPasswordController,
                        "Current Password", Icons.lock,
                        obscure: true),
                    const SizedBox(height: 10),
                    _buildTextField(
                        _newPasswordController, "New Password", Icons.lock_open,
                        obscure: true),
                    const SizedBox(height: 10),
                    _buildTextField(_confirmPasswordController,
                        "Confirm Password", Icons.lock_outline,
                        obscure: true),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.image),
                        const SizedBox(width: 10),
                        const Text("Profile Picture"),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            filePick(ImageSource.gallery);
                            if (_imgFile != null) {
                              await uploadImage();
                              backend.updateUserData(
                                imgurl: imgurl,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("No image selected")),
                              );
                            }
                          },
                          child: const Text("Upload"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await backend.updateUserData(
                          username: _nameController.text.trim(),
                          // imgurl: imgurl,
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Save Name"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await changePassword();
                        _currentPasswordController.clear();
                      },
                      icon: const Icon(Icons.lock_reset),
                      label: const Text("Change Password"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: textColor),
              title: Text("App Settings", style: TextStyle(color: textColor)),
              trailing: Icon(
                  showAppSettings ? Icons.expand_less : Icons.expand_more,
                  color: textColor),
              onTap: () {
                setState(() {
                  showAppSettings = !showAppSettings;
                  showEditProfile = false;
                });
              },
            ),
            if (showAppSettings)
              Column(
                children: [
                  _drawerSubItem(Icons.feedback, "Feedback", context,
                      route: '/feedback'),
                  _drawerSubItem(Icons.help_outline, "FAQ", context,
                      route: '/faq'),
                  _drawerSubItem(
                      Icons.contact_support, "Contact Support", context,
                      route: '/contact'),
                ],
              ),
            const Divider(),
            _drawerMainItem(
                Icons.person_pin_circle, "User Preferences", context,
                route: '/preferences'),
            _drawerMainItem(Icons.history, "Conversion History", context,
                route: '/history'),
            const Divider(),
            _drawerMainItem(Icons.logout, "Logout", context, logout: true),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _drawerSubItem(IconData icon, String title, BuildContext context,
      {String? route}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (route != null) Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _drawerMainItem(IconData icon, String title, BuildContext context,
      {String? route, bool logout = false}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () async {
        Navigator.pop(context);
        if (logout) {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, '/loginPage');
          Get.snackbar("", "Logged out successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white);
        } else if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
