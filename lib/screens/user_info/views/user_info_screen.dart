import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to edit profile
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar & Name
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/avatar.png'), // Replace with real image
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Sepide Moqadasi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Sepide@piqo.design',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),

            // Profile fields
            const ProfileField(label: 'Name', value: 'Sepide'),
            const ProfileField(label: 'Date of birth', value: 'Oct 31, 1997'),
            const ProfileField(label: 'Phone number', value: '+1–202–555–0162'),
            const ProfileField(label: 'Gender', value: 'Female'),
            const ProfileField(label: 'Email', value: 'Sepide@piqo.design'),
            const ProfileField(
              label: 'Password',
              value: 'Change Password',
              isLink: true,
              linkColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final bool isLink;
  final Color? linkColor;

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
    this.isLink = false,
    this.linkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: isLink ? linkColor ?? Colors.blue : Colors.black,
              fontWeight: isLink ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
        const Divider(height: 1),
        const SizedBox(height: 10),
      ],
    );
  }
}
