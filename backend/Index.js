const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors");
const PORT = 5500;
const app = express();
dotenv.config();
const issueRoute = require("./Route/issueRoute");
const responseRoute = require("./Route/responseRoute");
const userRoute = require("./Route/userRoute");
const reportRoute = require("./Route/reportRoute");
const scheduleRoute = require("./Route/scheduleRoute");
const vehicleRoute = require("./Route/vehicleRoute")


// middleware
app.use(cors());
app.use(express.json());
app.use("/api/user", userRoute);
app.use("/api/schedule", scheduleRoute);
app.use("/api/vehicle", vehicleRoute);
app.use("/api/issue", issueRoute);
app.use("/api/report", reportRoute);
app.use("/api/response", responseRoute);
app.use((req, res, next) => {
  next();
});


mongoose.set("strictQuery", false);

mongoose
  .connect(process.env.Mongo_URI, { useNewUrlParser: true })
  .then(console.log("connected successfully!"));

app.listen(PORT, () => {
  console.log(`Server is listening on  ${PORT}`);
});
