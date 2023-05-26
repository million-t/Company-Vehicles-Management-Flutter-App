
const mongoose = require('mongoose')


const Schema = mongoose.Schema
const issueSchema = new Schema({
    
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

    content: {
        type: String,
        required: true
    },
    status: {
        type: String,
        default: "pending"
    },
    response: {
        type: String,
        default: ""
    }
    
}, {timestamps: true})

module.exports = mongoose.model('Issue', issueSchema)