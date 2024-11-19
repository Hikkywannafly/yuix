import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:yuix/screens/onboarding/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passWord = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  File? _avatarImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Register'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundImage:
                      _avatarImage != null ? FileImage(_avatarImage!) : null,
                  child: _avatarImage == null
                      ? const Icon(Icons.camera_alt, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(email, 'Email', Icons.email),
              const SizedBox(height: 10),
              _buildTextField(userName, 'Username', Icons.person),
              const SizedBox(height: 10),
              _buildTextField(passWord, 'Password', Icons.lock,
                  obscureText: true),
              const SizedBox(height: 10),
              _buildTextField(confirmPassword, 'Confirm Password', Icons.lock,
                  obscureText: true),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryFixedVariant,
                    foregroundColor: Theme.of(context)
                                .colorScheme
                                .inverseSurface ==
                            Theme.of(context).colorScheme.onPrimaryFixedVariant
                        ? Colors.black
                        : Theme.of(context).colorScheme.onPrimaryFixedVariant ==
                                const Color(0xffe2e2e2)
                            ? Colors.black
                            : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface ==
                              Theme.of(context)
                                  .colorScheme
                                  .onPrimaryFixedVariant
                          ? Colors.black
                          : Theme.of(context)
                                      .colorScheme
                                      .onPrimaryFixedVariant ==
                                  const Color(0xffe2e2e2)
                              ? Colors.black
                              : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                color: Theme.of(context).colorScheme.outline,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text('Login here'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedImage =
          await File(pickedFile.path).copy('${directory.path}/$fileName');

      setState(() {
        _avatarImage = savedImage;
      });
    }
  }

  Future<void> _registerUser() async {
    if (passWord.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    var box = Hive.box('login-data');
    box.put('userInfo', [
      email.text,
      userName.text,
      passWord.text,
      _avatarImage?.path,
    ]);
    box.put('isFirstTime', false);
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainApp()),
    //   (route) => false,
    // );
  }
}
