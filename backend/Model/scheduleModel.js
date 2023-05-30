
const mongoose = require('mongoose')


const Schema = mongoose.Schema
const scheduleSchema = new Schema({
    
    driver_id: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    driver_name: {
        type: String,
        default: "",
    },

    manager_id: {
        type: Schema.Types.ObjectId, 
        required: true
    },
    manager_name: {
        type: String,
        default: "",
    },

    vehicle_id: {
        type: String, 
        default: "",
    },
    image: {
        type: String, 
        default: "",
    },
    license_plate_number: {
        type: String, 
        default: ""
    },

    start: {
        type: Date,
        required: true
    },

    end: {
        type: Date,
        required: true
    },
}, {timestamps: true})

module.exports = mongoose.model('schedule', scheduleSchema)