import React from "react";
import { Router, Route, Switch, Redirect } from "react-router-dom";
import { createBrowserHistory } from "history";
import AdminLayout from "layouts/Admin.js";
import { useStoreState } from "easy-peasy";

export default function App() {
  const hist = createBrowserHistory();
  const loggedin = useStoreState((state) => state.loggedin);

  return (
    <Router history={hist}>
      <Switch>
        <Route path="/admin" render={(props) => <AdminLayout {...props} />} />
        <Redirect to="/admin/dashboard" />
      </Switch>
    </Router>
  );
}
