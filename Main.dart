import 'dart:io';

void main() {
  int number = 3;
  double number2 = number.toDouble();
  int number3 = number2.toInt();
  String string4 = number3.toString();
  int number5 = int.parse(string4);
  List<dynamic> numbers = [1, 2, 3, 4];
  List<int> numbersMore =  numbers.cast<int>();

  print("${number2}"
      "\n${number3}"
      "\n${string4}"
      "\n${number5}"
      "\n${numbersMore}");
}