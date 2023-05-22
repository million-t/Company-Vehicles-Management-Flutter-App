const express = require('express')


const {
    createResponse,
    updateResponse,
    deleteResponse,
    getResponseToIssue
} = require('../Controller/responseController')

const responseAuth = require('../middleware/responseAuth')

const router = express.Router()

router.use(responseAuth)





//create an Response
router.post('/', createResponse)
//get an Response
router.get('/:id', getResponseToIssue)
//delete an Response
router.delete('/:id', deleteResponse)
//patch update an Response
router.patch('/:id', updateResponse)




module.exports = router
