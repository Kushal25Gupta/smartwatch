import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/user_controller/user_controller.dart';

class UserProfile extends StatelessWidget {
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'User Profile',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      userController.userPhotoUrl.value.isNotEmpty
                          ? userController.userPhotoUrl.value
                          : 'https://via.placeholder.com/150',
                    ),
                  )),
                  const SizedBox(height: 16),
                  Obx(() => Text(
                    userController.userName.value.isNotEmpty
                        ? userController.userName.value
                        : 'User',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                    userController.userEmail.value.isNotEmpty
                        ? userController.userEmail.value
                        : 'No Email',
                    style: const TextStyle(
                        fontSize: 18, color: Colors.grey),
                  )),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A11CB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}