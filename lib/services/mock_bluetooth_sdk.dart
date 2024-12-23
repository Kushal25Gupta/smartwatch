import 'dart:math';

class MockBluetoothSDK {
  Stream<int> getHeartRateStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      yield (60 + (10 * (1 - Random().nextDouble())).toInt());
    }
  }

  Stream<int> getStepCountStream() async* {
    int steps = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 5));
      steps += Random().nextInt(10);
      yield steps;
    }
  }
}