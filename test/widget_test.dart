import 'package:delivery_app/app/dw9_delivery_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(Dw9DeliveryApp());
  });
}
