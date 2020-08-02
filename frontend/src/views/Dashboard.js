import React from "react";
// react plugin used to create charts
import { Line, Pie } from "react-chartjs-2";
// reactstrap components
import {
  Card,
  CardHeader,
  CardBody,
  CardFooter,
  CardTitle,
  Row,
  Col,
} from "reactstrap";
// core components
// other components
import {
  dashboard24HoursPerformanceChart,
  // dashboardEmailStatisticsChart,
  // dashboardNASDAQChart,
  chartData,
} from "variables/charts.js";

import firebaseDb from "../Firebase";
import UpdateButton from "../components/UpdateButton";

class Dashboard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      updateHover: false,
      updateClass: "fas fa-sync-alt update-icon",
      totalCases: "",
      criticalCases: "",
      resolvedCases: "",
      monthlyCases: "",
      stateChartData: [],
    };
  }

  updateData = () => {
    firebaseDb
      .collection("global")
      .get()
      .then((snapshot) => {
        const data = snapshot.docs[0].data();
        this.setState({
          totalCases: data.totalCases,
          resolvedCases: data.resolved,
          monthlyCases: data.monthlyCases,
          criticalCases: data.criticalCases,
        });
      });

    firebaseDb
      .collection("chartData")
      .doc("cd")
      .get()
      .then((snapshot) => {
        const data = snapshot.data();
        console.log("snapshot data is ", data);
      });
    // (async () => {
    //   if (await chartData) {
    //     this.chartRef.chartInstance.update();
    //   }
    //   console.log(
    //     "chartData is ",
    //     await chartData(),
    //     "and chartref is ",
    //     this.chartRef
    //   );
    // })();
  };

  componentDidMount() {
    this.updateData();
  }

  render() {
    return (
      <>
        <div className="content">
          <Row>
            <Col lg="3" md="6" sm="6">
              <Card className="card-stats">
                <CardBody>
                  <Row>
                    <Col md="4" xs="5">
                      <div className="icon-big text-center icon-warning">
                        {/* <i className="nc-icon nc-globe text-warning" /> */}
                        <i className="fas fa-road text-warning" />
                      </div>
                    </Col>
                    <Col md="8" xs="7">
                      <div className="numbers">
                        <p className="card-category">Total Cases</p>
                        <CardTitle tag="p">{this.state.totalCases}</CardTitle>
                        <p />
                      </div>
                    </Col>
                  </Row>
                </CardBody>
                <CardFooter>
                  <hr />
                  <div className="stats">
                    {/* // ! TO USE <i className="fas fa-sync-alt update-icon" /> */}
                    <UpdateButton updateData={this.updateData} />
                    {/* <i className={this.state.updateClass} />{" "}
                    <a
                      onMouseEnter={() => {
                        this.hoverin();
                      }}
                      onMouseLeave={() => {
                        this.hoverout();
                      }}
                      onClick={() => this.updateData()}
                      href="#"
                    >
                      Update Now
                    </a> */}
                  </div>
                </CardFooter>
              </Card>
            </Col>
            <Col lg="3" md="6" sm="6">
              <Card className="card-stats">
                <CardBody>
                  <Row>
                    <Col md="4" xs="5">
                      <div className="icon-big text-center icon-warning">
                        {/* <i className="nc-icon nc-vector text-danger" /> */}
                        <i className="fas fa-exclamation text-danger" />
                      </div>
                    </Col>
                    <Col md="8" xs="7">
                      <div className="numbers">
                        <p className="card-category">Critical</p>
                        <CardTitle tag="p">
                          {this.state.criticalCases}
                        </CardTitle>
                        <p />
                      </div>
                    </Col>
                  </Row>
                </CardBody>
                <CardFooter>
                  <hr />
                  <div className="stats">
                    <i className="far fa-clock" /> Out of total cases
                  </div>
                </CardFooter>
              </Card>
            </Col>
            <Col lg="3" md="6" sm="6">
              <Card className="card-stats">
                <CardBody>
                  <Row>
                    <Col md="4" xs="5">
                      <div className="icon-big text-center icon-warning">
                        {/* <i className="nc-icon nc-money-coins text-success" /> */}
                        <i className="fas fa-check text-success" />
                      </div>
                    </Col>
                    <Col md="8" xs="7">
                      <div className="numbers">
                        <p className="card-category">Resolved</p>
                        <CardTitle tag="p">
                          {this.state.resolvedCases}
                        </CardTitle>
                        <p />
                      </div>
                    </Col>
                  </Row>
                </CardBody>
                <CardFooter>
                  <hr />
                  <div className="stats">
                    <i className="far fa-calendar" /> Out of total Cases
                  </div>
                </CardFooter>
              </Card>
            </Col>
            <Col lg="3" md="6" sm="6">
              <Card className="card-stats">
                <CardBody>
                  <Row>
                    <Col md="4" xs="5">
                      <div className="icon-big text-center icon-warning">
                        {/* <i className="nc-icon nc-favourite-28 text-primary" /> */}
                        <i
                          className="fa fa-angle-double-up text-primary"
                          aria-hidden="true"
                        ></i>
                      </div>
                    </Col>
                    <Col md="8" xs="7">
                      <div className="numbers">
                        <p className="card-category">Cases This Month</p>
                        <CardTitle tag="p">
                          +{this.state.monthlyCases}
                        </CardTitle>
                        <p />
                      </div>
                    </Col>
                  </Row>
                </CardBody>
                <CardFooter>
                  <hr />
                  <div className="stats">
                    <UpdateButton updateData={this.updateData} />
                    {/* <i className="fas fa-sync-alt" /> Update now */}
                  </div>
                </CardFooter>
              </Card>
            </Col>
          </Row>
          <Row>
            <Col md="12">
              <Card>
                <CardHeader>
                  <CardTitle tag="h5">Annual data</CardTitle>
                  {/* <p className="card-category">24 Hours performance</p> */}
                </CardHeader>
                <CardBody>
                  <Line
                    ref={(reference) => (this.chartRef = reference)}
                    data={dashboard24HoursPerformanceChart.data}
                    // data={await chartData}
                    options={dashboard24HoursPerformanceChart.options}
                    width={400}
                    height={100}
                  />
                </CardBody>
                <CardFooter>
                  {/* <hr />
                  <div className="stats">
                    <i className="fa fa-history" /> Updated 3 minutes ago
                  </div> */}
                </CardFooter>
              </Card>
            </Col>
          </Row>
        </div>
      </>
    );
  }
}

export default Dashboard;
