
const Issue = require('../Model/issueModel')
const mongoose = require('mongoose')
const jwt = require('jsonwebtoken')
const dotenv = require('dotenv');

//config vars
dotenv.config();



//==============================================================================================================
//create an Issue
const createIssue = async (req, res) => {
    const { 
        driver_id,
        manager_id,
        driver_name,
        content
        
     } = req.body

    try {
        const issue = await Issue.create({ 
            driver_id,
            manager_id,
            driver_name,
            content
         })
        res.status(200).json(issue)
    }
    catch (error) {
        res.status(400).json({error: error.message})
    }
}


//______________________________________________________________________________
// update a Issue
const updateIssue = async (req, res) => {

    
    const { id } = req.params
    const { _id } = req.user

    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Issue.'})
    }

    const issue = await Issue.findById(id)

    if (!issue){
        return res.status(404).json({error: 'No such Issue.'})
    }

    // if (issue.driver_id.toString() != _id.toString()){
    //     return res.status(401).json({ error: 'Unauthorized Request' })
    // }


    const patchIssue = await Issue.findOneAndUpdate({_id: id}, {
        ...req.body
    })

    const updatedIssue = await Issue.findById(id)

    res.status(200).json(updatedIssue)
}


//______________________________________________________________________________
//delete an Issue
const deleteIssue = async (req, res) => {

    
    
  const { id } = req.params
  const { _id } = req.user

  if (!mongoose.Types.ObjectId.isValid(id)){
      return res.status(404).json({error: 'No such Issue.'})
  }

  const issue = await Issue.findById(id)

  if (!issue){
      return res.status(404).json({error: 'No such Issue.'})
  }

  if (issue.driver_id.toString() != _id.toString()){
      return res.status(401).json({ error: 'Unauthorized Request' })
  }


    const deletedIssue = await Issue.findOneAndDelete({_id: id})
    

    res.status(200).json(deletedIssue)
}


//______________________________________________________________________________
//get a single Issue
const getIssue = async (req, res) => {
    const { id } = req.params
    
    
    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Issue.'})
    }

    const issue = await Issue.findById(id)
    
    if (!issue){
        return res.status(404).json({error: 'No such Issue.'})
    }

    res.status(200).json(issue)
}



// get all Issues of driver
const getAllIssueByDriver = async (req, res) => {
  const { _id } = req.user
    try {
        const issue = await Issue.find({ driver_id: _id }).sort({createdAt: 1})
    
        res.status(200).json(issue)
    }
    catch (error){
        res.status(404).json({error: "Couldn't fetch Issue."})
    }
    
}



// get all Issues to manager
const getAllIssueToManager = async (req, res) => {
    const { _id } = req.user
      try {
          const issue = await Issue.find({ manager_id: _id }).sort({createdAt: 1})
      
          res.status(200).json(issue)
      }
      catch (error){
          res.status(404).json({error: "Couldn't fetch Issue."})
      }
      
  }
//==============================================================================================================






module.exports = {
    createIssue,
    updateIssue,
    deleteIssue,
    getIssue,
    getAllIssueByDriver,
    getAllIssueToManager
}