import 'dart:io';

void main() {
  Map<String, int> namesNumbers = {
    'Fyke' : 22,
    'Simon' : 2
  };

  namesNumbers.forEach((k, v) => print("Names: ${k}, Numbers: ${v}"));
}