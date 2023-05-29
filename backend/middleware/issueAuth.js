const jwt = require('jsonwebtoken')
const User = require('../Model/userModel')

const issueAuth = async (req, res, next) => {
  
  const { authorization } = req.headers

  if (!authorization) {
    return res.status(401).json({ error: 'Authorization token required' })
  }

  const token = authorization.split(' ')[1]

  try {
    const { _id } = jwt.verify(token, process.env.SECRET)
    let user = await User.findOne({ _id })
    // .select('_id')
    if (!user){
      return res.status(401).json({ error: 'Not Authenticated' })
    }

    // if (user.type != 'driver'){
    //   console.log("bello", user.name)
    //     res.status(401).json({ error: 'Request is not authorized' })
    // }
    // else{
    req.user = user
    next()
    // }

  } catch (error) {
    console.log(error)
    res.status(401).json({ error: 'Request is not authorized' })
  }
}

module.exports = issueAuth