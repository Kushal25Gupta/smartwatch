class MockConnectedDevices {
  List<String> getConnectedDevices() {
    return ['Smartwatch', 'Headphones'];
  }

  void disconnectDevice(String device) {
    print('$device disconnected');
  }
}