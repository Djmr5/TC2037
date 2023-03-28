function exampleFunction(arg1, arg2) {
  let num = 0x1F;
  let year = 0;
  const age = 18; // default value
  // This is a comment
  if (arg1 == true) {
    year = 1453;
  } else {
    year = 2023;
  }
  switch (arg2) {
    case "Jose":
    case "Lydia":
      age = 20;
      break;
    case "Angel":
    case "Carolina":
      age = 19;
      break;
    default:
      break;
  }
  var x = 'hello';
  var y = 'world';
  return `${x}, ${y}! Age is ${age} and year is ${year}.`;
}
function otherFunction() {
  const NUM = 1234;
  const decimal = 1.4;
  const d = .45;
  const bool1 = true;
  const bool2 = false;
  const str = "string";

  for (let i = 0; i < NUM; i++) {
    if (i === 10) {
      console.log("i equals 10!");
      break;
    } else if (i === 5) {
      continue;
    }
    console.log(i);
  }

  switch (NUM) {
    case 1:
      console.log("NUM is 1");
      break;
    case 2:
      console.log("NUM is 2");
      break;
    case 3:
      console.log("NUM is 3");
      break;
    default:
      console.log("NUM is not 1, 2, or 3");
      break;
  }

  let f = 1;
  let x = 10 - f;
  if (x > 5) {
    console.log("x is greater than 5");
  } else {
    console.log("x is not greater than 5");
  }

  try {
    let arr = new Array(NUM);
    arr[0] = "Hello";
    arr[1] = "World";
    arr[2] = 1234;
    arr[3] = null;
    console.log(arr);
    throw "Something went wrong!";
  } catch (err) {
    console.log(err);
  }

  return;
}

function main() {
  var arg1 = true;
  var arg2 = "Jose";
  exampleFunction(arg1, arg2)
  if (arg1 != false) {
    otherFunction();
  }
  let x = 10;
  let y = 3;
  let remainder = x % y; // remainder = 1
}