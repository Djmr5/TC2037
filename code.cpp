#include <iostream>
#include <string>
using namespace std;

string exampleFunction(bool arg1, string arg2)
{
  int num = 0x1F;
  char myChar = 'a';
  int year = 0;
  int age = 18;
  // This is a comment
  if (arg1)
  {
    year = 1453;
  }
  else
  {
    year = 2023;
  }

  switch (arg2[0])
  {
  case 'J':
    if (arg2 == "Jose" || arg2 == "Lydia")
    {
      age = 20;
    }
    else
    {
      age = 18;
    }
    break;
  case 'A':
    if (arg2 == "Angel" || arg2 == "Carolina")
    {
      age = 19;
    }
    else
    {
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

void otherFunction()
{
  const int NUM = 1234;
  float decimal = 1.4;
  double d = .45;
  bool b1 = true;
  bool b2 = false;
  string str = "string";

  cout << NUM << endl;
  cout << decimal << endl;
  cout << d << endl;
  cout << b1 << endl;
  cout << b2 << endl;
  cout << str << endl;

  for (int i = 0; i < NUM; i++)
  {
    if (i == 10)
    {
      cout << "i equals 10!" << endl;
      break;
    }
    else if (i == 5)
    {
      continue;
    }
    cout << i << endl;
  }

  switch (NUM)
  {
  case 1:
    cout << "NUM is 1" << endl;
    break;
  case 2:
    cout << "NUM is 2" << endl;
    break;
  case 3:
    cout << "NUM is 3" << endl;
    break;
  default:
    cout << "NUM is not 1, 2, or 3" << endl;
    break;
  }

  int f = 1;
  int x = 10 - f;
  if (x > 5)
  {
    cout << "x is greater than 5" << endl;
  }
  else
  {
    cout << "x is not greater than 5" << endl;
  }

  try
  {
    int *ptr = new int[NUM];
    if (ptr == NULL)
    {
      throw "Memory allocation failed!";
    }
    delete[] ptr;
  }
  catch (const char *msg)
  {
    cout << msg << endl;
  }
}

int main()
{
  bool arg1 = true;
  string arg2 = "Jose";
  cout << exampleFunction(arg1, arg2) << endl;
  if (arg1 != false)
  {
    otherFunction();
  }
  int x = 10;
  int y = 3;
  int remainder = x % y; // remainder = 1
  return 0;
}
