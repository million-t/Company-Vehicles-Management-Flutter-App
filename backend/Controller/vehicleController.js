
const Vehicle = require('../Model/vehicleModel')
const mongoose = require('mongoose')
const jwt = require('jsonwebtoken')
const dotenv = require('dotenv');

//config vars
dotenv.config();



//==============================================================================================================
//create a Vehicle
const createVehicle = async (req, res) => {
    const { 
      license_plate_number,
      name,
      manager_id,
      image
     } = req.body

    try {
        const vehicle = await Vehicle.create({ 
          license_plate_number,
          name,
          manager_id,
          image
         })
        res.status(200).json(vehicle)
    }
    catch (error) {
        res.status(400).json({error: error.message})
    }
}


//______________________________________________________________________________
// update a Vehicle
const updateVehicle = async (req, res) => {

    
    const { id } = req.params
    const { _id } = req.user
    // const { check } = req.check

    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Vehicle.'})
    }

    const vehicle = await Vehicle.findById(id)

    if (!vehicle){
        return res.status(404).json({error: 'No such Vehicle.'})
    }

    if (vehicle.manager_id.toString() != _id.toString()){
        // console.log(vehicle.manager_id, check)
        return res.status(401).json({ error: 'Unauthorized Request' })
    }

    const upvehicle = await Vehicle.findOneAndUpdate({_id: id}, {
        ...req.body
    })
    const updatedVehicle = await Vehicle.findById(id)
    

    res.status(200).json(updatedVehicle)
}


//______________________________________________________________________________
//delete a vehicle
const deleteVehicle = async (req, res) => {

    
    
  const { id } = req.params
  const { _id } = req.user
//   const { check } = req.check

  if (!mongoose.Types.ObjectId.isValid(id)){
      return res.status(404).json({error: 'No such Vehicle.'})
  }

  const vehicle = await Vehicle.findById(id)

  if (!vehicle){
      return res.status(404).json({error: 'No such Vehicle.'})
  }

  if (vehicle.manager_id.toString() != _id.toString()){
      return res.status(401).json({ error: 'Unauthorized Request' })
  }


    const deletedVehicle = await Vehicle.findOneAndDelete({_id: id})
    

    res.status(200).json(deletedVehicle)
}


//______________________________________________________________________________
//get a single Vehicle
const getVehicle = async (req, res) => {
    const { id } = req.params
    
    
    if (!mongoose.Types.ObjectId.isValid(id)){
        return res.status(404).json({error: 'No such Vehicle.'})
    }

    const vehicle = await Vehicle.findById(id)
    
    if (!vehicle){
        return res.status(404).json({error: 'No such Vehicle.'})
    }

    res.status(200).json(vehicle)
}



// get all Vehicle
const getAllVehicle = async (req, res) => {
  const { _id } = req.user
  
    try {
        const vehicle = await Vehicle.find({ manager_id: _id }).sort({createdAt: 1})
    
        res.status(200).json(vehicle)
    }
    catch (error){
        res.status(404).json({error: "Couldn't fetch Vehicle."})
    }
    
}
//==============================================================================================================






module.exports = {
    createVehicle,
    updateVehicle,
    deleteVehicle,
    getVehicle,
    getAllVehicle
}