import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class YourBmiView extends GetView<RegisterController> {
  const YourBmiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YourBmiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'YourBmiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
