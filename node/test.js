const path = require("path");
const hello = "Hello from Node JS Variable!"
console.log(hello)

console.log (`Printing variable hello: ${hello}`);

console.log("Directory name: " + __dirname);
console.log("Directory and file name: " + __filename);

console.log("Using PATH Module:");
console.log(`Hello from file ${path.basename(__filename)}`);

console.log(`Process args: ${process.argv}`)