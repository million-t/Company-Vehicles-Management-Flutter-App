
const mongoose = require('mongoose')


const Schema = mongoose.Schema
const responseSchema = new Schema({
    
    driver_id: {
        type: Schema.Types.ObjectId,
        required: true,
    },

    manager_id: {
        type: Schema.Types.ObjectId, 
        required: true
    },

    content: {
        type: String,
        required: true
    },
    issue_id: {
      type: Schema.Types.ObjectId,
      required: true,
    }
    
}, {timestamps: true})

module.exports = mongoose.model('Response', responseSchema)