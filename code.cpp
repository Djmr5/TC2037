#include <iostream>
#include <string>
using namespace std;

string exampleFunction(bool arg1, string arg2) {
  int year = 0;
  int age = 18;
  // This is a comment
  if (arg1) {
    year = 1453;    
  } else {
    year = 2023;
  }

  switch(arg2[0]) {
    case 'J':
      if (arg2 == "Jose" || arg2 == "Lydia") {
        age = 20;
      } else {
        age = 18;
      }
      break;
    case 'A':
      if (arg2 == "Angel" || arg2 == "Carolina") {
        age = 19;
      } else {
        age = 18;
      }
      break;
    default:
      age = 18;
      break;
  }

  string x = "hello";
  string y = "world";
  return x + ", " + y + "!";
}

int main() {
  bool arg1 = true;
  string arg2 = "Jose";
  cout << exampleFunction(arg1, arg2) << endl;
  return 0;
}
