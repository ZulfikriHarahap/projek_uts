import 'package:flutter_test/flutter_test.dart';

import 'package:projek_uts/main.dart';

void main() {
  testWidgets('Quiz app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app starts and displays the title / home screen elements.
    expect(find.text('Kuis Pilihan Ganda'), findsWidgets);
    expect(find.text('Mulai Kuis'), findsOneWidget);
  });
}
