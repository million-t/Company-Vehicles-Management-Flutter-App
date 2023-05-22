const mongoose = require('mongoose')


const Schema = mongoose.Schema
const vehicleSchema = new Schema({
  
    license_plate_number: {
      type: String,
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    manager_id: {
      type: Schema.Types.ObjectId,
      required: true,
    },
    image: {
      type: String,
      required: true,
    }
  
}, {timestamps: true})

module.exports = mongoose.model('Vehicle', vehicleSchema)