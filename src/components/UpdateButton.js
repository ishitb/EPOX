import React, { useState } from "react";
import { Grid } from "@material-ui/core";

const UpdateButton = ({ updateData }) => {
  const [hover, setHover] = useState(false);
  const [classname, setClassname] = useState("fas fa-sync-alt update-icon");
  const [fetching, setfetching] = useState(false);

  const hoverin = ({ updateData }) => {
    setHover(true);
    setClassname("fas fa-sync-alt fa-spin update-icon");
  };

  const hoverout = () => {
    setHover(false);
    setClassname("fas fa-sync-alt update-icon");
  };

  //   useEffect(() => {
  //     setfetching();
  //   }, [input]);

  return (
    <>
      <i className={classname} />{" "}
      <a
        onMouseEnter={hoverin}
        onMouseLeave={hoverout}
        onClick={() => {
          setfetching(true);
          updateData();
          setTimeout(() => {
            setfetching(false);
          }, 1000);
        }}
        href="#"
      >
        Update Now
      </a>
      <p style={{ position: "absolute", top: "75%", left: "60%" }}>
        {fetching ? "Fetching Data" : ""}
      </p>
    </>
  );
};

export default UpdateButton;
