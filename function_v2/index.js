const functions = require("firebase-functions");

exports.helloWorld = functions.https.onRequest((request, response) => {
  console.log("Hello, World!");
  response.send("Hello, World!");
});
