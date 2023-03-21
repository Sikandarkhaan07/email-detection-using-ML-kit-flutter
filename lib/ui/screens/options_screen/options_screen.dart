import 'package:flutter/material.dart';

import 'options_controller.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who You Are?'),
      ),
      body: ListView.builder(
        itemCount: OptionsController.titles.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(context, OptionsController.routes[index]);
          },
          child: SizedBox(
            height: 100,
            child: Card(
              color: Colors.cyan,
              elevation: 4,
              margin: const EdgeInsets.all(5),
              child: Text(
                OptionsController.titles[index],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
