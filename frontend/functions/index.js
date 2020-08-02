const functions = require("firebase-functions");
// const firebaseDb = require("Firebase");
const admin = require("firebase-admin");
// admin.initializeApp();
// const admin = require("firebase-admin");
var serviceAccount = require("./sihproject-epox-firebase-adminsdk-xzw1w-63bdd81006.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://sihproject-epox.firebaseio.com",
});

exports.updateGlobal = functions.firestore
  .document("/submissions/{id}")
  .onCreate((snapshot, context) => {
    admin
      .firestore()
      .collection("global")
      .doc("IRcogUtURyBiDMFoVgiI")
      .update({
        totalCases: admin.firestore.FieldValue.increment(1),
        monthlyCases: admin.firestore.FieldValue.increment(1),
      });

    const data = snapshot.data();
    const month = data.date.substring(5, 7);
    const monthObj = {};
    const monthNameTally = {
      "01": "Jan",
      "02": "Feb",
      "03": "Mar",
      "04": "Apr",
      "05": "May",
      "06": "Jun",
      "07": "Jul",
      "08": "Aug",
      "09": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec",
    };

    monthObj[month] = {
      total: admin.firestore.FieldValue.increment(1),
      month: monthNameTally[month],
    };

    admin.firestore().doc("chartData/cd").set(monthObj, {
      merge: true,
    });

    return null;
  });
