const express = require('express')


const {
    createIssue,
    updateIssue,
    deleteIssue,
    getIssue,
    getAllIssueByDriver,
    getAllIssueToManager
} = require('../Controller/issueController')

const issueAuth = require('../middleware/issueAuth')

const router = express.Router()

router.use(issueAuth)





//create an Issue
router.post('/', createIssue)

//get all Issue of under a manager
router.get('/driver', getAllIssueByDriver)
router.get('/manager', getAllIssueToManager)

//get an Issue


router.get('/:id', getIssue)
//delete an Issue
router.delete('/:id', deleteIssue)
//patch update an Issue
router.patch('/:id', updateIssue)





module.exports = router
