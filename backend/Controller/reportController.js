
const Report = require('../Model/reportModel')
const mongoose = require('mongoose')

const User = require('../Model/userModel')
const jwt = require('jsonwebtoken')
const dotenv = require('dotenv');

// get config vars
dotenv.config();



//==============================================================================================================
//create a Report
const createReport = async (req, res) => {

    const { driver_id,
        manager_id,
        driver_name,
        vehicle_name,
        distance,
        litres,
        price } = req.body

    try {
        const report = await Report.create({ driver_id,
            manager_id,
            driver_name,
            vehicle_name,
            distance,
            litres,
            price })
        res.status(200).json(report)
    }
    catch (error) {
        res.status(400).json({error: error.message})
    }
}


//______________________________________________________________________________
// update a report
const updateReport = async (req, res) => {

    const { id } = req.params
    
    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Report.'})
    }

    const report = await Report.findById(id)

    if (!report){
        return res.status(404).json({error: 'No such Report.'})
    }


    const  upReport = await Report.findOneAndUpdate({_id: id}, {
        ...req.body
    })
    const updatedReport = await Report.findById(id)
    

    res.status(200).json(updatedReport)
}


//______________________________________________________________________________
//delete a report
const deleteReport = async (req, res) => {

    
    
    const { id } = req.params
    const { _id } = req.user
  //   const { check } = req.check
  
    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Report.'})
    }
  
    const report = await Report.findById(id)
  
    if (!report){
        return res.status(404).json({error: 'No such Report.'})
    }
  
    if (report.driver_id.toString() != _id.toString()){
        return res.status(401).json({ error: 'Unauthorized Request' })
    }
  
  
      const deletedReport = await Report.findOneAndDelete({_id: id})
      
  
      res.status(200).json(deletedReport)
  }
  
  

//______________________________________________________________________________
//get a single report
const getReport = async (req, res) => {
    const { id } = req.params
    
    
    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Report.'})
    }

    const report = await Report.findById(id)
    
    if (!report){
        return res.status(404).json({error: 'No such Report.'})
    }

    res.status(200).json(report)
}



// get all Report
const getAllReportToManager = async (req, res) => {
  const { _id } = req.user
  
    try {
        const report = await Report.find({ manager_id: _id }).sort({createdAt: 1})
    
        res.status(200).json(report)
    }
    catch (error){
        res.status(404).json({error: "Couldn't fetch Report."})
    }
    
}
const getAllReportByDriver = async (req, res) => {
    const { _id } = req.user
    
      try {
          const report = await Report.find({ driver_id: _id }).sort({createdAt: 1})
      
          res.status(200).json(report)
      }
      catch (error){
          res.status(404).json({error: "Couldn't fetch Report."})
      }
      
  }



module.exports = {
    createReport,
    updateReport,
    deleteReport,
    getReport,
    getAllReportToManager,
    getAllReportByDriver
}