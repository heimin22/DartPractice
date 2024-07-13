import 'dart:io';


void main() {
  stdout.write("Enter your name: ");
  String? name = stdin.readLineSync();

  stdout.write("\nEnter your age:");
  int? age = int.tryParse(stdin.readLineSync()!);

  print("${name} is ${age} years old");
}