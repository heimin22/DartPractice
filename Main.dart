import 'dart:io';

void main() {
  Set<int> numbers = {};

  numbers.addAll({1, 2 , 3});

  numbers.forEach((numbersAdded) => stdout.write(numbersAdded));
}