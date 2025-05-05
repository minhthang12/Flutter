import 'package:flutter/material.dart';
import 'package:shop/models/customer.dart';
import 'package:shop/services/api_service.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  Customer? customer;
  @override
  void initState() {
    super.initState();
    loadCustomer();
  }

  void loadCustomer() async {
    final result = await ApiService.getCustomer();
    print('Customer loaded: ${result}');

    setState(() {
      customer = result;
    });
    print(customer);
  }

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
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer!.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      customer!.email,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),

            // Profile fields
            ProfileField(label: 'Display Name', value: customer!.name),
            ProfileField(label: 'Phone number', value: customer!.phone),
            ProfileField(label: 'Email', value: customer!.email),
            ProfileField(label: 'User Name', value: customer!.username),
            ProfileField(label: 'Role', value: customer!.role),
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
