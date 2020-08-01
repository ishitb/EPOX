import React from "react";

// reactstrap components
import {
  Card,
  CardHeader,
  CardBody,
  CardTitle,
  Table,
  Row,
  Col,
} from "reactstrap";
import firebaseDb from "../Firebase";

import StatusSelector from "../components/StatusSelector";
import { TextField, Grid } from "@material-ui/core";

class Tables extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: [],
      submissions: [],
      query: "",
      submissionsFiltered: [],
    };
  }

  handleSearchChange = (e) => {
    const query = e.target.value;
    const sf = this.state.submissions.filter((sub) => {
      // return sub.status > 1;
      return sub.username.toLowerCase().includes(query.toLowerCase());
    });

    console.log();

    this.setState({
      query: query,
      submissionsFiltered: sf,
    });
  };

  updateData = () => {
    // ! Get submissions
    firebaseDb
      .collection("submissions")
      .get()
      .then((snapshot) => {
        snapshot.forEach((doc) => {
          var subs = {
            id: doc.id,
            ...doc.data(),
          };
          this.setState({
            submissions: this.state.submissions.concat(subs),
          });
        });
      });

    firebaseDb
      .collection("users")
      .get()
      .then((snapshot) => {
        snapshot.forEach((doc) => {
          var users = {
            id: doc.id,
            ...doc.data(),
          };
          this.setState({
            users: this.state.users.concat(users),
          });
        });
      });
  };

  componentDidMount() {
    this.updateData();
  }

  render() {
    return (
      <>
        <div className="content">
          <Row>
            <Col md="12">
              <Card>
                <CardHeader>
                  <Grid container justify="space-between">
                    <CardTitle tag="h4">All Users</CardTitle>
                    {/* <TextField
                      onChange={this.handleSearchChange}
                      label="Search by username"
                      variant="filled"
                    /> */}
                  </Grid>
                </CardHeader>
                <CardBody>
                  <Table responsive>
                    <thead className="text-primary">
                      <tr>
                        <th>Username</th>
                        <th>Name</th>
                        <th>Number of Submissions</th>
                        <th>Credibility Score</th>
                      </tr>
                    </thead>
                    <tbody>
                      {this.state.users.map((user) => (
                        <tr key={user.id}>
                          <td>{user.username}</td>
                          <td>{user.name}</td>
                          <td>{user.noOfSubmissions}</td>
                          <td>{user.credibilityScore}</td>
                        </tr>
                      ))}
                    </tbody>
                  </Table>
                </CardBody>
              </Card>
            </Col>
            {/* // ! ----------------------------> */}
            <Col md="12">
              <Card>
                <CardHeader>
                  <Grid container justify="space-between">
                    <CardTitle tag="h4">All Submissions</CardTitle>
                    <TextField
                      onChange={this.handleSearchChange}
                      label="Search by username"
                      variant="filled"
                    />
                  </Grid>
                </CardHeader>
                <CardBody>
                  <Table responsive>
                    <thead className="text-primary">
                      <tr>
                        <th>Email ID</th>
                        <th>Time</th>
                        <th>Severity</th>
                        <th>Status</th>
                        <th className="text-left">Preview</th>
                      </tr>
                    </thead>
                    <tbody>
                      {this.state.query === ""
                        ? this.state.submissions.map((sub) => {
                            return (
                              <tr key={sub.id}>
                                <td>{sub.username}</td>
                                <td>{sub.time}</td>
                                <td>{sub.pci}</td>
                                {/* <td>{sub.status}</td> */}
                                <td style={{ width: "20%" }}>
                                  <StatusSelector
                                    status={sub.status}
                                    id={sub.id}
                                  />{" "}
                                </td>
                                <td style={{ width: "10px" }}>
                                  <a
                                    href={sub.imageURL}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                  >
                                    <img src={sub.imageURL} />
                                  </a>
                                </td>
                              </tr>
                            );
                          })
                        : this.state.submissionsFiltered.length > 0
                        ? this.state.submissionsFiltered.map((sub) => {
                            return (
                              <tr key={sub.id}>
                                <td>{sub.username}</td>
                                <td>{sub.time}</td>
                                {/* <td>{sub.pci}</td> */}
                                <td>{Math.round(Math.random() * 100)}</td>
                                <td style={{ width: "20%" }}>
                                  <StatusSelector
                                    status={sub.status}
                                    id={sub.id}
                                  />{" "}
                                </td>
                                <td style={{ width: "10px" }}>
                                  <a
                                    href={sub.imageURL}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                  >
                                    <img src={sub.imageURL} />
                                  </a>
                                </td>
                              </tr>
                            );
                          })
                        : ""}
                    </tbody>
                  </Table>
                </CardBody>
              </Card>
            </Col>
          </Row>
        </div>
      </>
    );
  }
}

export default Tables;
