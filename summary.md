# Models

### `Doctor`

It holds the information about doctors and they usual working hours

Relevant columns:
* `name`: Self-explanatory
* `start_hour`: Integer 0-24, indicates when the doctor starts a duty
* `end_hour`: Integer 0-24, indicates when the doctor ends a duty

### `Slot`

It's the time slot available to book for an appointment.

Relevant columns:

* `doctor_id`: Reference to `doctors` table, each slot belongs to one doctor.
* `starts_at`: Datetime column indicating when the slot stats (they have fixed length of 30 minutes)

### `Appointment`

It's the actual appointment record.

Relevant columns:

* `slot_id`: Reference to `slots` table. Each slot can have up to 1 appointment (via has_one association). There's a validation on the `Appointment` side that prevents assigning already occupied slot to the appointment.
* `patient_name`: Self-explanatory
* `patient_phone`: Self-explanatory

# Explanation/analysis

I weighted two options: One of them was calculating of slots on the fly without actually saving them into the database. The other, that remained, was storing the empty slots in the database. The first option would spare me the effort in calculating the slots in advance, but had many disadvantages: It complicated actual endpoints, made things like doctors holidays much more difficult (as for now, we can simply delete necessary slots).

Slots are generated using SlotCreator service that takes a `Doctor` instance, start time and end time and creates slots between these time boundaries, taking into account existing slots, weekends and doctor's working hours. For now, the main method of the slots creation is the `populate:slots` rake task, but eventually I would probably use `Sidekiq` worker with some logic to generate the slots automatically as the service would grow and we was in need of such automatization.

Obviously, this is a basic functionality that would run somewhere on the internal server and let internal worker make appropriate appointments etc. If we'd like to exend this to, i.e., letting the patients to make appointments themselves, we would need to create some logic to confirm creation/edition/deletion of appointments by patients, using for example tokens sent by e-mail. My application doesn't include such things, but can quite easily be expanded with them, according to the planned growth of the product.
