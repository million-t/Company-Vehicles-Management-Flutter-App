
const mongoose = require('mongoose')


const Schema = mongoose.Schema
const reportSchema = new Schema({
    
    driver_id: {
        type: Schema.Types.ObjectId,
        required: true,
    },

    manager_id: {
        type: Schema.Types.ObjectId, 
        required: true
    },

    driver_name: {
        type: String, 
        required: true
    },

    vehicle_name: {
        type: String,
        required: true
    },

    distance: {
        type: String,
    },
    litres: {
        type: String,
        required: true
    },
    price: {
        type: String,
        required: true
    },
}, {timestamps: true})

module.exports = mongoose.model('Report', reportSchema)