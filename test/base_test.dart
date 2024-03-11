import 'package:flutter_test/flutter_test.dart';

int add(int a, int b) {
  return a + b;
}

void main() {
  test('Addition Test', () {
    // Arrange
    int result;

    // Act
    result = add(3, 4);

    // Assert
    expect(result, 7);
  });
}
