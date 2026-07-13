import 'package:auto_start_flutter/auto_start_flutter.dart';

void main() async {
  var available = await isAutoStartAvailable;
  print(available);
}
