void main() {
//   print('A');
//   fetchData();
//   print('C');

  MyClass obj= MyClass();

  print(obj._privateNumber);


}


// Future<void> fetchData() async {
//   print('B');
//   await Future.delayed(Duration(seconds: 2));
//   print('D');
// }

class MyClass{
  int _privateNumber=21;
//   void privateMethod(){
//     print("private");

//   }

}