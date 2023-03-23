#include <iostream>
#include <string>

using namespace std;

string exampleFunction(int arg1, int arg2) {
  // This is a comment
    // This is a comment
      // This is a comment
  string x = "hello";
  string y = "world";
  return x + ", " + y + "!";
}

int main() {
  int a = 1;
  int b = 2;
  string result = exampleFunction(a, b);
  cout << result << endl;
  return 0;
}
