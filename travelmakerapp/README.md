Database -> Database
entities -> Classes and sync with DB and Interface
presentation -> Transform use case data to be shown on screen
UI -> Screens (what goes to the user)
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
  - Starting up the app:
    - Checks if there is a user created ()
    - Not in that case, you need to create an user, getting his name and age ()
  - get the name and icon experience by the id
  - get the experiences from one travelStop (from table experiencesList)
  - 


Function logic

Providers:


- entitiesProvider:
  - Stores an instance of every entitie of the app
  - 