Database -> Database
entities -> Classes and sync with DB and Interface
presentation -> screens(front)
usecase -> back-end (interfaces) 


interface:

*User starts the app and give his name and age on StartScreen bf going to HomeScreen 

Classes: 
- User
  - Person

- Person
  - Name
  - Age
  - Picture (optional)

- Travel
  - TravelID
  - Travel Name
  - Start Date
  - Arrival Date
  - Members list
  - Experiences
  - *TravelStop* List
  - Vehicle desired

- TravelStop
  - travelStopID
  - City name
  - City Coordinates 
  - Arrival Date
  - Out Date
  - Time spent
  - Description 
  - Experiences List

- TravelScript
    - TravelID
    - Travel
    - Travel map (generate)


- TravelMap
  - TravelStop List (get coordinates)
  - Start point
  - 
