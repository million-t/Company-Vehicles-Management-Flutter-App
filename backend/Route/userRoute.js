const express = require("express");
const {
  signupUser,
  loginUser,
  getUser,
  updateUser,
  deleteUser,
} = require("../Controller/userController");

const router = express.Router();

// login
router.post("/login", loginUser);

// signup
router.post("/signup", signupUser);

// get user info
router.get("/", getUser);

router.patch("/", updateUser);

router.delete("/", deleteUser);

module.exports = router;
