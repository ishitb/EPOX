import firebase from "firebase";

// Web app's Firebase configuration
var firebaseConfig = {
  apiKey: "AIzaSyBVS0np5RpJWLFxEcIY78uHgA23tP4IZZ0",
  authDomain: "sihproject-epox.firebaseapp.com",
  databaseURL: "https://sihproject-epox.firebaseio.com",
  projectId: "sihproject-epox",
  storageBucket: "sihproject-epox.appspot.com",
  messagingSenderId: "531451556931",
  appId: "1:531451556931:web:48709e16749f3e3bcd90f6",
  measurementId: "G-PRFP4JCCBM",
};
// Initialize Firebase
var fireDb = firebase.initializeApp(firebaseConfig);
firebase.analytics();

// export default fireDb.database().ref();
export default fireDb.firestore();