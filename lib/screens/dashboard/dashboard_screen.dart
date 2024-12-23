import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import '../../controller/history_controller/history_controller.dart';
import '../../controller/user_controller/user_controller.dart';
import '../../services/mock_bluetooth_sdk.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MockBluetoothSDK _bluetoothSDK = MockBluetoothSDK();
  final HistoryController historyController = Get.put(HistoryController());
  final UserController userController = Get.find();
  late StreamSubscription<int> _heartRateSubscription;
  late StreamSubscription<int> _stepCountSubscription;
  int _heartRate = 0;
  int _stepCount = 0;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _heartRateSubscription.cancel();
    _stepCountSubscription.cancel();
    super.dispose();
  }

  void _startListening() {
    _heartRateSubscription = _bluetoothSDK.getHeartRateStream().listen((rate) {
      setState(() {
        _heartRate = rate;
      });
    });

    _stepCountSubscription = _bluetoothSDK.getStepCountStream().listen((steps) {
      setState(() {
        _stepCount = steps;
      });
    });

    Timer.periodic(Duration(minutes: 1), (timer) {
      _saveData();
    });
  }

  void _saveData() {
    final date = DateTime.now().toIso8601String();
    historyController.addRecord(date, _heartRate, _stepCount);
  }

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
                      children: [
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          _isConnected
                              ? Icons.bluetooth_connected
                              : Icons.bluetooth_disabled,
                          color: _isConnected ? Colors.green : Colors.red,
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
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfo(),
                    const SizedBox(height: 20),
                    _buildHealthDataCard('Heart Rate', '$_heartRate bpm',
                        Icons.favorite, Colors.red),
                    const SizedBox(height: 20),
                    _buildHealthDataCard('Steps', '$_stepCount',
                        Icons.directions_walk, Colors.blue),
                    const SizedBox(height: 20),
                    _buildAdditionalInfo(),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
          userController.userName.value,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        )),
        Obx(() => Text(
          userController.userEmail.value,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        )),
      ],
    );
  }

  Widget _buildHealthDataCard(
      String label, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 40),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const Spacer(),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey[300]!, strokeWidth: 0.5),
                    getDrawingVerticalLine: (value) =>
                        FlLine(color: Colors.grey[300]!, strokeWidth: 0.5),
                  ),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                          10,
                              (index) => FlSpot(
                              index.toDouble(),
                              double.parse((Random().nextDouble() * 100)
                                  .toStringAsFixed(1)))),
                      isCurved: true,
                      color: color,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                          show: true, color: color.withOpacity(0.3)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Daily Motivation',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              '"The only bad workout is the one that didn’t happen."',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}