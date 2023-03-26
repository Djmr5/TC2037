function exampleFunction(arg1, arg2) {
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
