/*!

=========================================================
* Paper Dashboard React - v1.2.0
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-dashboard-react
* Copyright 2020 Creative Tim (https://www.creative-tim.com)

* Licensed under MIT (https://github.com/creativetimofficial/paper-dashboard-react/blob/master/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*/
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

class Tables extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: [],
      submissions: [],
    };
  }

  updateData = () => {
    // ! Get users
    firebaseDb
      .collection("users")
      .get()
      .then((snapshot) => {
        snapshot.forEach((doc) => {
          const subs = doc.data().submissions;
          var sub;

          if (typeof subs !== "undefined" && subs.length > 0) {
            sub = {
              emailID: doc.data().emailID,
              submissions: doc.data().submissions,
            };
          }

          this.setState({
            users: this.state.users.concat(doc.data()),
          });
        });
      });

    // ! Set submissions
    // this.setState({
    //    this.state.users.map((user) => {
    //     console.log(user);
    //   }),
    // });
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
                  <CardTitle tag="h4">
                    All Users {console.log(this.state.users)}
                  </CardTitle>
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
                        <tr key={user.emailID}>
                          <td>{user.username}</td>
                          <td>{user.name}</td>
                          <td>{user.noOfSubmissions}</td>
                          <td>{user.credibilityScore}</td>
                        </tr>
                      ))}
                      {/* {console.log(this.state.submissions)} */}
                      {/* <tr>
                        <td>Minerva Hooper</td>
                        <td>Curaçao</td>
                        <td>Sinaai-Waas</td>
                        <td className="text-right">$23,789</td>
                      </tr>
                      <tr>
                        <td>Sage Rodriguez</td>
                        <td>Netherlands</td>
                        <td>Baileux</td>
                        <td className="text-right">$56,142</td>
                      </tr>
                      <tr>
                        <td>Philip Chaney</td>
                        <td>Korea, South</td>
                        <td>Overland Park</td>
                        <td className="text-right">$38,735</td>
                      </tr>
                      <tr>
                        <td>Doris Greene</td>
                        <td>Malawi</td>
                        <td>Feldkirchen in Kärnten</td>
                        <td className="text-right">$63,542</td>
                      </tr>
                      <tr>
                        <td>Mason Porter</td>
                        <td>Chile</td>
                        <td>Gloucester</td>
                        <td className="text-right">$78,615</td>
                      </tr>
                      <tr>
                        <td>Jon Porter</td>
                        <td>Portugal</td>
                        <td>Gloucester</td>
                        <td className="text-right">$98,615</td>
                      </tr> */}
                    </tbody>
                  </Table>
                </CardBody>
              </Card>
            </Col>
            {/* // ! ----------------------------> */}
            <Col md="12">
              <Card>
                <CardHeader>
                  <CardTitle tag="h4">All Submissions</CardTitle>
                </CardHeader>
                <CardBody>
                  <Table responsive>
                    <thead className="text-primary">
                      <tr>
                        <th>Email ID</th>
                        <th>Time</th>
                        <th>Severity</th>
                        <th>Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      {this.state.users.map((user) => {
                        console.log(user);
                        return user.submissions.map((sub, index) => (
                          <tr key={(user.emailID, index)}>
                            <td>{user.name}</td>
                            <td>{sub.time}</td>
                            <td>{sub.severity}</td>
                            <td>{sub.status}</td>
                          </tr>
                        ));
                      })}
                    </tbody>
                  </Table>
                </CardBody>
              </Card>
            </Col>
            {/* // ! ----------------------------> */}
            {/* <Col md="12">
              <Card className="card-plain">
                <CardHeader>
                  <CardTitle tag="h4">Table on Plain Background</CardTitle>
                  <p className="card-category">
                    Here is a subtitle for this table
                  </p>
                </CardHeader>
                <CardBody>
                  <Table responsive>
                    <thead className="text-primary">
                      <tr>
                        <th>Name</th>
                        <th>Country</th>
                        <th>City</th>
                        <th className="text-right">Salary</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>Dakota Rice</td>
                        <td>Niger</td>
                        <td>Oud-Turnhout</td>
                        <td className="text-right">$36,738</td>
                      </tr>
                      <tr>
                        <td>Minerva Hooper</td>
                        <td>Curaçao</td>
                        <td>Sinaai-Waas</td>
                        <td className="text-right">$23,789</td>
                      </tr>
                      <tr>
                        <td>Sage Rodriguez</td>
                        <td>Netherlands</td>
                        <td>Baileux</td>
                        <td className="text-right">$56,142</td>
                      </tr>
                      <tr>
                        <td>Philip Chaney</td>
                        <td>Korea, South</td>
                        <td>Overland Park</td>
                        <td className="text-right">$38,735</td>
                      </tr>
                      <tr>
                        <td>Doris Greene</td>
                        <td>Malawi</td>
                        <td>Feldkirchen in Kärnten</td>
                        <td className="text-right">$63,542</td>
                      </tr>
                      <tr>
                        <td>Mason Porter</td>
                        <td>Chile</td>
                        <td>Gloucester</td>
                        <td className="text-right">$78,615</td>
                      </tr>
                      <tr>
                        <td>Jon Porter</td>
                        <td>Portugal</td>
                        <td>Gloucester</td>
                        <td className="text-right">$98,615</td>
                      </tr>
                    </tbody>
                  </Table>
                </CardBody>
              </Card>
            </Col> */}
          </Row>
        </div>
      </>
    );
  }
}

export default Tables;
