import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class NiftyPointsView extends GetView<RegisterController> {
  const NiftyPointsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NiftyPointsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NiftyPointsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
