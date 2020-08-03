import firebaseDb from "../Firebase";

async function getData() {
  let promise = firebaseDb
    .collection("chartData")
    .doc("cd")
    .get()
    .then((snapshot) => {
      return snapshot.data();
    });

  let data = await promise;

  let totalData = Object.keys(data).map((val) => data[val]["total"]);
  let labels = Object.keys(data).map((val) => data[val]["month"]);
  let allData = {
    totalData,
    labels,
  };
  return allData;
}

export const chartDataFetch = async () => {
  let data = await getData();
  return data;
};
