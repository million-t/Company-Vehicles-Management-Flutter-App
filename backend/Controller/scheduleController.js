const Schedule = require("../Model/scheduleModel");
const mongoose = require("mongoose");

//==============================================================================================================
//create a schedule
const createSchedule = async (req, res) => {
  const {
    driver_id,
    driver_name,
    manager_id,
    manager_name,
    vehicle_id,
    start,
    end,
    
  } = req.body;

  try {
    const schedule = await Schedule.create({
      driver_id,
      driver_name,
      manager_id,
      manager_name,
      vehicle_id,
      start,
      end,
    });

    res.status(200).json(schedule);
  } catch (error) {
    console.log(error);
    res.status(400).json({ error: error.message });
  }
};

//______________________________________________________________________________
// update a Schedule
const updateSchedule = async (req, res) => {
  const { id } = req.params;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(404).json({ error: "No such Schedule." });
  }

  const schedule = await Schedule.findOneAndUpdate(
    { _id: id },
    {
      ...req.body,
    }
  );

  if (!schedule) {
    return res.status(404).json({ error: "No such Schedule." });
  }

  const updatedSchedule = await Schedule.findById(id);
  res.status(200).json(updatedSchedule);
};
//______________________________________________________________________________
//delete a schedule
const deleteSchedule = async (req, res) => {
  const { id } = req.params;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(404).json({ error: "No such schedule." });
  }

  const schedule = await Schedule.findOneAndDelete({ _id: id });

  if (!schedule) {
    return res.status(404).json({ error: "No such schedule" });
  }

  res.status(200).json(schedule);
};

//______________________________________________________________________________
//get a single schedule
const getSchedule = async (req, res) => {
  const { id } = req.params;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(404).json({ error: "No such schedule." });
  }

  const schedule = await Schedule.findById(id);

  if (!schedule) {
    return res.status(404).json({ error: "No such schedule." });
  }

  res.status(200).json(schedule);
};

//______________________________________________________________________________


const getAllSchedulesOfDriver = async (req, res) => {
  try {
    const schedules = await Schedule.find({}).sort({ createdAt: -1 });

    res.status(200).json(schedules);
  } catch (error) {
    res.status(404).json({ error: "Couldn't fetch schedules." });
  }
};
//==============================================================================================================

const getAllSchedulesByManager = async (req, res) => {
  const id = req.params["id"];
  try {
    const schedules = await Schedule.find({ manager_id: id }).sort({
      createdAt: -1,
    });

    res.status(200).json(schedules);
  } catch (error) {
    res.status(404).json({ error: "Couldn't fetch schedules." });
  }
};

module.exports = {
  createSchedule,
  updateSchedule,
  deleteSchedule,
  getSchedule,
  getAllSchedulesOfDriver,
  getAllSchedulesByManager,
};
