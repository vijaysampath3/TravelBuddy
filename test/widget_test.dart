import 'package:flutter_test/flutter_test.dart';
import 'package:travelbuddy/main.dart';

void main() {
  testWidgets('Travel Buddy App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelBuddyApp());
    expect(find.text('Login as Buddy'), findsOneWidget);
  });
}
