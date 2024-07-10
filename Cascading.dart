import 'dart:convert';

class Example{
  var a;
  var b;
  void bSetter(b) {
    this.b = b;
  }
  void printValue() {
    print(this.a);
    print(this.b);
  }
}

void main() {
  Example eg1 = new Example();
  Example eg2 = new Example();

  print("Example 1 results: ");
  eg1
    ..a = 8
    ..bSetter(53)
    ..printValue();

  print("Example 2 results: ");
  eg2.a = 88;
  eg2.bSetter(53);
  eg2.printValue();
}