void main() {
  List<int> x = [1, 2, 3];
  x.insert(0, 50);
  print(x);
  var test = List.generate(3, (index) => index - 2);
  print(test);
}
