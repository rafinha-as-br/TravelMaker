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
  - Get data & time and set if it's good morning, afternoon or night


Function logic

Providers:


- entitiesProvider:
  - Stores an instance of every entitie of the app
  - List of persons: (The first person is the Person who is using the app)



- Ideas:
  - After pressed "continue" on the startScreen, an alert to advise that the user can change it's data at the configuration area

to do:
- Need to get the location by the device and place it on the sharedPref to get the LOCALE (need a function)
- On main: need to place the locale as part of localization of the USER instance inside userProvider
  - On USER instance: calls the function of get device location
  - 