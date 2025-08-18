
class TravelFormValidators{
  static String? travelTitleValidator(String? value){
    if(value==null) {return 'titleEmpty';}
    if(value.length<2){return 'titleShort';}
    return null;
  }
}