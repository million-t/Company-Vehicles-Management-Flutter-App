const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const validator = require("validator");

//--------------------------------------------------------------------------------------------------
const Schema = mongoose.Schema;
//==================================================================================================
const userSchema = new Schema({
  name: {
    type: String,
    required: true,
  },

  email: {
    type: String,
    required: true,
    unique: true,
  },

  password: {
    type: String,
    required: true,
  },

  type: {
    type: String,
    required: true,
  },

  manager_id: {
    type: Schema.Types.ObjectId,
  }
});

// signup
//==================================================================================================

userSchema.statics.signup = async function (
  name,
  email,
  password,
  type,
  manager_id
) {
  if (!name || !email || !password || !type) {
    throw Error("All required fields must be filled.");
  }

  if (!validator.isEmail(email)) {
    throw Error("Invalid Email.");
  }

  if (!validator.isStrongPassword(password)) {
    throw Error(
      "Password must be at least 8 characters long, contain a number, a special character and have an uppercase letter."
    );
  }

  const exists = await this.findOne({ email });

  if (exists) {
    throw Error("Email already in use.");
  }

  const salt = await bcrypt.genSalt(10);
  const hash = await bcrypt.hash(password, salt);

  const user = await this.create({
    name,
    email,
    password: hash,
    type,
    manager_id
  });

  return user;
};

// login
//==================================================================================================
userSchema.statics.login = async function (email, password) {
  if (!email || !password) {
    throw Error("All fields must be filled.");
  }

  const user = await this.findOne({ email });

  if (!user) {
    throw Error("Incorrect email");
  }

  const match = await bcrypt.compare(password, user.password);

  if (!match) {
    throw Error("Incorrect password");
  }

  return user;
};

module.exports = mongoose.model("User", userSchema);
