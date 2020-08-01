const { action, createStore } = require("easy-peasy");

const store = createStore({
  loggedin: false,
  login: action((state, payload) => {
    state.loggedin = payload;
    console.log("loggedin is ", state.loggedin);
  }),
});

export default store;
