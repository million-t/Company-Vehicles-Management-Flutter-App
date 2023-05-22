const express = require('express')


const {
    createVehicle,
    updateVehicle,
    deleteVehicle,
    getVehicle,
    getAllVehicle,
} = require('../Controller/vehicleController')

const requireAuth = require('../middleware/vehicleAuth')

const router = express.Router()

router.use(requireAuth)





//create a vehicle
router.post('/', createVehicle)
//get a Vehicle
router.get('/:id', getVehicle)
//delete a Vehicle
router.delete('/:id', deleteVehicle)
//patch update a Vehicle
router.patch('/:id', updateVehicle)
//get all Vehicles of under a manager
router.get('/', getAllVehicle)




module.exports = router