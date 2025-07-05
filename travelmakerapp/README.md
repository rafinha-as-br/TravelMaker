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
  - Travel Name
  - Start Date
  - Arrival Date
  - Members list
  - Experiences
  - *TravelStop* List
  - Vehicle choosed

- TravelStop
  - City name
  - City Coordinates 
  - Arrival Date
  - Out Date
  - Time spent
  - Descritpion 
  - Experienses List

- TravelScript
    - Travel Name
    - Start Date
    - Arrival Date
    - Members list
    - Experiences List
    - *TravelStop* List
    - Vehicle choosed
    - Full Travel Script
