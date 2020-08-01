user = {
  emailID: "",
  username: "",
  password: "",
  FirstName: "",
  LastName: "",
  noOfsubmissions: "",
  credibilityScore: "",
  submissions: [
    {
      // ! This is one of many items in array
      image: "",
      latitude: "",
      longitude: "",
      date: "",
      time: "",
      severity: "",
      status: "",
    }, // ! -------------------------------->
  ],
};

global = {
  totalCases: "",
  resolved: "",
  criticalCases: "",
  newCases: "",
  chartData: [
    {
      // * This is one of many items in array
      date: "",
      casesToday: "",
      resolvedToday: "",
      criticalToday: "",
    }, // * -------------------------------->
  ],
  markers: [
    {
      // ? This is one of many items in array
      username: "",
      submissions: [
        {
          // * This is one of many items in array
          latitude: "",
          longitude: "",
          severity: "",
          resolved: "",
        }, // * -------------------------------->
      ],
    }, // ? -------------------------------->
  ],
};
