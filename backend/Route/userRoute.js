const express = require("express");
const {
  signupUser,
  loginUser,
  getUser,
  updateUser,
  deleteUser,
  getDrivers
} = require("../Controller/userController");

const router = express.Router();

// login
router.post("/login", loginUser);

// signup
router.post("/signup", signupUser);

// get user info
router.get("/", getUser);

//get drivers
router.get("/drivers", getDrivers);

router.patch("/", updateUser);

router.delete("/", deleteUser);

module.exports = router;
