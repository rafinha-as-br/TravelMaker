
/// experiences enum
enum Experiences{

  /// historic experience
  historic,

  /// religious experience
  religious,

  /// gastronomic experience
  gastronomic,

  /// cultural experience
  cultural,

  /// tour experience
  tour,

  /// nature experience
  nature
}

/// to get from the database
Experiences getExperienceById(String id){
  late Experiences experience;
  
  switch(id){
    case '1':
      experience = Experiences.historic;
    case '2':
      experience = Experiences.religious;
    case '3' :
      experience = Experiences.gastronomic;
    case '4' :
      experience = Experiences.cultural;
    case '5' :
      experience = Experiences.tour;
    case '6' :
      experience = Experiences.nature;
  }
  
  return experience;
}

/// to throw to the database
String getExperienceId(Experiences experience){
  switch(experience){
    case Experiences.historic:
      return '1';
    case Experiences.religious:
      return '2';
    case Experiences.gastronomic:
      return '3';
    case Experiences.cultural:
      return '4';
    case Experiences.tour:
      return '5';
    case Experiences.nature:
      return '6';
  }
}
