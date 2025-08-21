
class TravelFormValidators{

  // travel title validator
  static String? travelTitleValidator(String? value){
    if(value==null) {return 'titleEmpty';}
    if(value.length<2){return 'titleShort';}
    return null;
  }

  // travel description validator
  static String? travelDescriptionValidator(String? value){
    if(value==null) {return 'Description';}
    if(value.length<2){return 'DescriptionShort';}
    return null;
  }

  //final destination validator


  // date selector validator


  // deshired vehicle selector validator


  // map error to message


  //validator of travel


  //validator of stop


  // validator of person


  //validator of data


}