/// @author    Diego
/// @since     2022-07-06
/// @copyright 2022 Carshare Australia Pty Ltd.


import 'package:fleetcutter_helpers/number_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberHelper', (){
    test('Random number is generated inside the ranges', () {
      double number = NumberHelper.getRandomNumber(100, 200);
      expect(number >= 100 && number <= 200, true);
      number = NumberHelper.getRandomNumber(200, 100);
      expect(number >= 100 && number <= 200, true);

      number = NumberHelper.getRandomNumber(1, 2);
      expect(number >= 1 && number <= 2, true);
      number = NumberHelper.getRandomNumber(2, 1);
      expect(number >= 1 && number <= 2, true);

      number = NumberHelper.getRandomNumber(1.5, 1.6);
      expect(number >= 1.5 && number <= 1.6, true);
      number = NumberHelper.getRandomNumber(1.6, 1.5);
      expect(number >= 1.5 && number <= 1.6, true);

      number = NumberHelper.getRandomNumber(-10, -3);
      expect(number >= -10 && number <= -3, true);
      number = NumberHelper.getRandomNumber(-3, -10);
      expect(number >= -10 && number <= -3, true);
    });
  });
}
