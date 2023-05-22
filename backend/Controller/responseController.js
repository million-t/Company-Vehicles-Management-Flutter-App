
const Response = require('../Model/responseModel')
const mongoose = require('mongoose')
const jwt = require('jsonwebtoken')
const dotenv = require('dotenv');

//config vars
dotenv.config();



//==============================================================================================================
//create a Response
const createResponse = async (req, res) => {
    const { 
      driver_id,
      manager_id,
      content,
      issue_id
        
     } = req.body

    try {
        const response = await Response.create({ 
          driver_id,
          manager_id,
          content,
          issue_id
            
         })
        res.status(200).json(response)
    }
    catch (error) {
        res.status(400).json({error: error.message})
    }
}


//______________________________________________________________________________
// update a Response
const updateResponse = async (req, res) => {

    
    const { id } = req.params
    const { _id } = req.user

    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Response.'})
    }

    const response = await Response.findById(id)

    if (!response){
        return res.status(404).json({error: 'No such Response.'})
    }

    if (response.manager_id.toString() != _id.toString()){
        return res.status(401).json({ error: 'Unauthorized Response' })
    }


    const patchedResponse = await Response.findOneAndUpdate({_id: id}, {
        ...req.body
    })
    const updatedResponse = await Response.findById(id)
    

    res.status(200).json(updatedResponse)
}


//______________________________________________________________________________
//delete an Response
const deleteResponse = async (req, res) => {

    
    
  const { id } = req.params
  const { _id } = req.user

  if (!mongoose.Types.ObjectId.isValid(id)){
      return res.status(404).json({error: 'No such Response.'})
  }

  const response = await Response.findById(id)

  if (!response){
      return res.status(404).json({error: 'No such Response.'})
  }

  if (response.manager_id.toString() != _id.toString()){
      return res.status(401).json({ error: 'Unauthorized Request' })
  }


    const deletedResponse = await Response.findOneAndDelete({_id: id})
    

    res.status(200).json(deletedResponse)
}


//______________________________________________________________________________
//get a single Response
const getResponseToIssue = async (req, res) => {
  const { id } = req.params
  // const { user } = req.user
    try {
        const response = await Response.find({ issue_id: id }).sort({createdAt: 1})
    
        res.status(200).json(response)
    }
    catch (error){
        res.status(404).json({error: "Couldn't fetch response."})
    }
    
}

//==============================================================================================================






module.exports = {
    createResponse,
    updateResponse,
    deleteResponse,
    getResponseToIssue
}