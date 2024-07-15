import 'dart:io';

void main() {
  List<int> integers = [1, 2, 3];
  List<int> cubes = integers.map((int n) => n * n * n).toList();

  cubes.forEach((cubedNumbers) => print(cubedNumbers));
}