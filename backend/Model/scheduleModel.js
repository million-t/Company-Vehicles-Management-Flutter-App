
const mongoose = require('mongoose')


const Schema = mongoose.Schema
const scheduleSchema = new Schema({
    
    driver_id: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    driver_name: {
        type: String,
        required: true,
    },

    manager_id: {
        type: Schema.Types.ObjectId, 
        required: true
    },
    manager_name: {
        type: String,
        required: true,
    },

    vehicle_id: {
        type: Schema.Types.ObjectId, 
        required: true
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