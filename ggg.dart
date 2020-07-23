void main() {
  var x = Test();
  x
    ..a()
    ..b()
    ..c();
}

class Test {
  void a() {
    print("a");
  }

  void b() {
    print("b");
  }

  void c() {
    print("c");
  }
}
