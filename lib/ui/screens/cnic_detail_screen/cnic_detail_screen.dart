import 'package:flutter/material.dart';

class CnicDetailScreen extends StatelessWidget {
  final Map<String, dynamic> cnicData;
  const CnicDetailScreen({super.key, required this.cnicData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Container(
        height: 400,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ListTile(
              leading: const Text('Name: '),
              title: Text(cnicData['name']),
            ),
            ListTile(
              leading: const Text('CNIC #: '),
              title: Text(cnicData['cnicNumber']),
            ),
            ListTile(
              leading: const Text('Expiry Date: '),
              title: Text(cnicData['expiryDate']),
            ),
          ],
        ),
      ),
    );
  }
}
