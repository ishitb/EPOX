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
import { data } from "jquery";

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
      graph: "",
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

    let total = [];
    let labels = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    firebaseDb
      .collection("chartData")
      .doc("cd")
      .get()
      .then((snapshot) => {
        const Cdata = snapshot.data();
        console.log("snapshot data is ", Cdata);
        for (const month of labels) {
          Object.keys(Cdata).map((index) => {
            if (Cdata[index].month === month) {
              total.push(parseInt(Cdata[index].total));
            }
          });
        }

        this.setState({
          stateChartData: {
            // labels: labels,
            labels: labels,
            datasets: [
              // {
              //   borderColor: "#6bd098",
              //   backgroundColor: "#6bd098",
              //   pointRadius: 0,
              //   pointHoverRadius: 0,
              //   borderWidth: 3,
              //   data: [300, 310, 316, 322, 330, 326, 333, 345, 338, 354, 13, 14],
              //   // data: total,
              // },
              // {
              //   borderColor: "#f17e5d",
              //   backgroundColor: "#f17e5d",
              //   pointRadius: 0,
              //   pointHoverRadius: 0,
              //   borderWidth: 3,
              //   data: [320, 340, 365, 360, 370, 385, 390, 384, 408, 420, 11, 12],
              //   // data: total,
              // },
              {
                borderColor: "#fcc468",
                backgroundColor: "#fcc468",
                pointRadius: 0,
                pointHoverRadius: 0,
                borderWidth: 3,
                // data: [370, 394, 415, 409, 425, 445, 460, 450, 478, 484],
                data: total,
              },
            ],
          },
        });
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
    this.state.graph = this.updateData();
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
                    // data={dashboard24HoursPerformanceChart.data}
                    data={this.state.stateChartData}
                    // data={{
                    //   labels: [
                    //     "Jan",
                    //     "Feb",
                    //     "Mar",
                    //     "Apr",
                    //     "May",
                    //     "Jun",
                    //     "Jul",
                    //     "Aug",
                    //     "Sep",
                    //     "Oct",
                    //   ],
                    //   datasets: [
                    //     {
                    //       borderColor: "#6bd098",
                    //       backgroundColor: "#6bd098",
                    //       pointRadius: 0,
                    //       pointHoverRadius: 0,
                    //       borderWidth: 3,
                    //       data: [
                    //         300,
                    //         310,
                    //         316,
                    //         322,
                    //         330,
                    //         326,
                    //         333,
                    //         345,
                    //         338,
                    //         354,
                    //       ],
                    //     },
                    //     {
                    //       borderColor: "#f17e5d",
                    //       backgroundColor: "#f17e5d",
                    //       pointRadius: 0,
                    //       pointHoverRadius: 0,
                    //       borderWidth: 3,
                    //       data: [
                    //         320,
                    //         340,
                    //         365,
                    //         360,
                    //         370,
                    //         385,
                    //         390,
                    //         384,
                    //         408,
                    //         420,
                    //       ],
                    //     },
                    //     {
                    //       borderColor: "#fcc468",
                    //       backgroundColor: "#fcc468",
                    //       pointRadius: 0,
                    //       pointHoverRadius: 0,
                    //       borderWidth: 3,
                    //       data: [
                    //         370,
                    //         394,
                    //         415,
                    //         409,
                    //         425,
                    //         445,
                    //         460,
                    //         450,
                    //         478,
                    //         484,
                    //       ],
                    //       // data:
                    //     },
                    //   ],
                    // }}
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
