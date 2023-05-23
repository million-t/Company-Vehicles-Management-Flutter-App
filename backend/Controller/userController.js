const User = require("../Model/userModel");
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");
const dotenv = require("dotenv");

// get config vars
dotenv.config();

const createToken = (_id) => {
  return jwt.sign({ _id }, process.env.SECRET, { expiresIn: "7d" });
};

// login
const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.login(email, password);

    // jwt token
    let _id = user._id;
    let type = user.type;
    const token = createToken(_id);
    res.status(200).json({ type, _id, token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// signup
const signupUser = async (req, res) => {
    const { name,
            email,
            password,
            type,
            manager_id 
            } = req.body;

//   console.log(req.body);
  try {
    const user = await User.signup(
        name,
        email,
        password,
        type,
        manager_id
    );

    // jwt token
    let _id = user._id;
    let _type = user.type;
    const token = createToken(_id);
    res.status(200).json({ _type, _id, token });
  } catch (error) {
    console.log(error);
    res.status(400).json({ error: error.message });
  }
};

// get a user
const getUser = async (req, res) => {
  const { authorization } = req.headers;

  if (!authorization) {
    return res.status(401).json({ error: "Authorization token required" });
  }

  const token = authorization.split(" ")[1];
  let id;
  try {
    const { _id } = jwt.verify(token, process.env.SECRET);
    id = _id;
  } catch (error) {
    res.status(401).json({ error: "Unauthorized Request" });
  }

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(404).json({ error: "No such user." });
  }

  const user = await User.findById(id);

  if (!user) {
    return res.status(404).json({ error: "No such user." });
  }

  res.status(200).json(user);
};

// update a user
const updateUser = async (req, res) => {
  const { authorization } = req.headers;

  if (!authorization) {
    return res.status(401).json({ error: "Authorization token required" });
  }

  const token = authorization.split(" ")[1];
  let id;
  try {
    const { _id } = jwt.verify(token, process.env.SECRET);
    id = _id;
  } catch (error) {
    res.status(401).json({ error: "Unauthorized Request" });
  }

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(404).json({ error: "No such user" });
  }

  const user = await User.findOneAndUpdate(
    { _id: id },
    {
      ...req.body,
    }
  );

  if (!user) {
    return res.status(404).json({ error: "No such user." });
  }
  const updatedUser = await User.findById(id);
  res.status(200).json(updatedUser);
};

//______________________________________________________________________________
//delete a user
const deleteUser = async (req, res) => {
  const { authorization } = req.headers;

  if (!authorization) {
    return res.status(401).json({ error: "Authorization token required" });
  }

  const token = authorization.split(" ")[1];
  let id;
  try {
    const { _id } = jwt.verify(token, process.env.SECRET);
    id = _id;
  } catch (error) {
    res.status(401).json({ error: "Unauthorized Request" });
  }

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(404).json({ error: "No such user" });
  }

  const user = await User.findOneAndDelete({ _id: id });

  if (!user) {
    return res.status(404).json({ error: "No such user." });
  }

  res.status(200).json(user);
};

module.exports = {
  signupUser,
  loginUser,
  getUser,
  updateUser,
  deleteUser,
};
