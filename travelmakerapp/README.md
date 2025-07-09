Database -> Database
entities -> Classes and sync with DB and Interface
presentation -> screens(front)
usecase -> back-end (interfaces) 


interface:

*User starts the app and give his name and age on StartScreen bf going to HomeScreen 

Classes:

- Person
  - Name
  - Age
  - ProfilePicture Path

- Travel
  - TravelID
  - Travel Name
  - Start Date
  - Arrival Date
  - Vehicle desired

- On app
  - *TravelStop* List
  - Members list

- TravelStop
  - From database
    - travelStopID
    - City name
    - Arrival Date
    - Out Date
    - Time spent
    - Description 
  - on app
    - Experiences List

- Experiences
  - Receives from database
    - experienseID (Table Experienses)
    - experiences (table ExperiensesList)

- TravelScript
    - TravelID
    - Travel
    - Travel map (generate)


- TravelMap
  - TravelStop List (get coordinates)
  - Start point
  - 



functions:
  - 
  - get the name and icon experience by the id
  - get the experiences from one travelStop (from tabel experiencesList)
  - 


Funcion logic
