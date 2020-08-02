import firebaseDb from "../Firebase";

async function getData() {
  let promise = firebaseDb
    .collection("chartData")
    .doc("cd")
    .get()
    .then((snapshot) => {
      //   console.log("snapshot is ", snapshot.data());
      return snapshot.data();
    });

  let data = await promise;
  //   console.log("internal data is", data);
  let totalData = Object.keys(data).map((val) => data[val]["total"]);
  let labels = Object.keys(data).map((val) => data[val]["month"]);
  let allData = {
    totalData,
    labels,
  };
  return allData;
  // console.log("promise is ", data);
}

// let data;

export const chartDataFetch = async () => {
  let data = await getData();
  return data;
  // console.log("data is ", data.totalData, data.labels);
};

// setData();
