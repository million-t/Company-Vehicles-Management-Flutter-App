const express = require('express')


const {
    createReport,
    updateReport,
    deleteReport,
    getReport,
    getAllReportToManager,
    getAllReportByDriver
} = require('../Controller/reportController')

const reportAuth = require('../middleware/reportAuth')

const router = express.Router()

router.use(reportAuth)





//create a report
router.post('/', createReport)

//get all report of under a manager
router.get('/driver', getAllReportByDriver)
router.get('/manager', getAllReportToManager)
//get a report
router.get('/:id', getReport)
//delete a report
router.delete('/:id', deleteReport)
//patch update a report
router.patch('/:id', updateReport)





module.exports = router