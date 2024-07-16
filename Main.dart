import 'dart:io';

void main() {

  List<String> nameList = ["Fyke", "Simon", "Visco", "Tonel"];

  for (String listNames in nameList) {
    stdout.write(listNames + ' ');
  }

  print('\n');

  Map<String, int> namesNumbers = {
    'Fyke' : 22,
    'Simon' : 2
  };

  namesNumbers.forEach((k, v) => print("Names: ${k}, Numbers: ${v}"));
}