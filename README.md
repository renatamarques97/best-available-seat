# Best Available Seat
A solution to return the best seat (closest to the front & middle)
given a list of open seats. Rows follow alphabetical order
with "a" being the first row. Columns follow numerical order
from left to right.

### Ruby version
```
2.6.4
```

### Rails version
```
6.0.2.2
```

### Configuration
```shell
bundle install
yarn install
```

### Database creation
```shell
bundle exec rails db:setup
or
bundle exec rails db:create
bundle exec rails db:migrate
```

### How to run the test suite
```shell
bundle exec rspec
```

### Run the server
```shell
bundle exec rails server -p 3001
```

## Documentation

POST
The first phase, create a venue and define the size:
- Venue creation with rows and columns with
automatic labels on the seats, based on row
and column (ex: a1, e4) and all by default being available.

```
localhost:3000/api/venues
```
input example:
```json
{
  "venue": {
    "name": "Theater",
    "rows": 3,
    "columns": 3
  }
}
```
output:
```json
{
  "status": "SUCCESS",
  "message": "Venue Successfully Created"
}
```


The second phase, define which seats are occupied:
- With all the labels defined, it's time to tell if there are any seat(s) occupied.

PUT
- Update just a single seat:

```
localhost:3000/api/seats/[:id]
```
input example:
```json
{
  "available": "false"
}
```
output:
```json
{
  "status": "SUCCESS",
  "message": "Seat Successfully Updated"
}
```
POST
- Update a batch of seats:

```
localhost:3001/api/batch_update_seats
```
input example:
```json
{
  "seats_ids": ["342", "343"],
  "available": false
}
```
output:
```
{
  "status": "SUCCESS",
  "message": "Seat Successfully Updated"
}
```


GET
The third and last phase:
- Get the best seat, passing the amount that the person desired.

```
localhost:3000/api/best_seats?venue_id=[:venue_id]&seats_requested=[:seats_requested]
```
output exemple:
```json
{
  "status": "SUCCESS",
  "message": "Best Seat Successfully Found",
  "data": [
    "B2"
  ]
}
```

