import React, { useState } from "react";

// Material ui components
import InputLabel from "@material-ui/core/InputLabel";
import MenuItem from "@material-ui/core/MenuItem";
import FormControl from "@material-ui/core/FormControl";
import Select from "@material-ui/core/Select";
import CheckCircleIcon from "@material-ui/icons/CheckCircle";

// Firebase
import FirebaseDb from "../Firebase";
import { Grid, Box, Typography } from "@material-ui/core";

const StatusSelector = ({ status, id }) => {
  const [Status, setStatus] = useState(status);
  const [checkChanged, changed] = useState(false);

  if (checkChanged) {
    setTimeout(() => {
      changed(false);
    }, 3000);
  }

  const handleChange = (event) => {
    setStatus(event.target.value);
    FirebaseDb.collection("submissions")
      .doc(id)
      .update({
        status: event.target.value,
      })
      .then(changed(true));
  };

  return (
    <Grid container direction="row" alignItems="center">
      <Grid item xs={6}>
        <FormControl>
          <InputLabel>Status </InputLabel>
          <Select value={Status} onChange={handleChange}>
            <MenuItem value={0}>reported</MenuItem>
            <MenuItem value={1}>working</MenuItem>
            <MenuItem value={2}>resolved</MenuItem>
            <MenuItem value={3}>spam</MenuItem>
          </Select>
        </FormControl>
      </Grid>
      <Grid item>
        {checkChanged ? (
          <CheckCircleIcon fontSize="large" style={{ color: "green" }} />
        ) : (
          ""
        )}
      </Grid>
    </Grid>
  );
};

export default StatusSelector;
