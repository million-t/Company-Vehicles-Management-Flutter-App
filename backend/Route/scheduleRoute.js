const express = require('express')
const scheduleAuth = require('../middleware/scheduleAuth')
const {
    createSchedule,
    updateSchedule,
    deleteSchedule,
    getSchedule,
    getAllSchedulesOfDriver,
    getAllSchedulesByManager
} = require('../Controller/scheduleController')


const router = express.Router()

router.use(scheduleAuth)



//create a Schedule
router.post('/', createSchedule)
// get all Schedules by a manager
router.get('/manager/:id', getAllSchedulesByManager)
//get all Schedules of driver
router.get('/driver/:id', getAllSchedulesOfDriver)
//get a Schedule
router.get('/:id', getSchedule)
//delete a Schedule
router.delete('/:id', deleteSchedule)
//patch update a Schedule
router.patch('/:id', updateSchedule)





module.exports = router