import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    // Define Finders to locate widgets from the app.
    final counterTextFinder = find.byValueKey('counterText');
    final buttonFinder = find.byTooltip('Increment');
    final buttonAdd = find.byValueKey("add");
    final buttonSubtract = find.byValueKey("subtract");
    final alertText = find.byValueKey("alert_text");
    final btnClose = find.byValueKey("close_button");

    FlutterDriver?
        driver; // FlutterDriver should be nullable to conform with null safety

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Increment the counter', () async {
      // First, tap on the button
      await driver!.tap(buttonFinder);

      // Then, verify the counter text has been incremented by 1
      expect(await driver!.getText(counterTextFinder), "1");

      // Tap the button again
      await driver!.tap(buttonFinder);

      // Then, verify the counter text has been incremented by 1 again
      expect(await driver!.getText(counterTextFinder), "2");
    });

    test("Test with alert window", () async {
      await driver!.tap(buttonAdd);

      // Verify the alert dialog text
      expect(
          await driver!.getText(alertText), "Welcome to ExecuteAutomation 2");

      // Tap the close button to close the alert box
      await driver!.tap(btnClose);

      // Tap the subtract button
      await driver!.tap(buttonSubtract);

      // Verify if the counter is decremented
      expect(await driver!.getText(counterTextFinder), "1");
    });
  });
}
