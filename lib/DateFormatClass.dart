import 'package:intl/intl.dart';


class DateFormatClass
{
  static getFullMonth(month){
    String rst="";
    switch (month){
      case 1:
        rst = "janvier";
        break;
      case 2:
        rst = "février";
        break;
      case 3:
        rst = "mars";
        break;
      case 4:
        rst = 'avril';
        break;
      case 5:
        rst = 'mai';
        break;
      case 6:
        rst = "juin";
        break;
      case 7:
        rst = "juillet";
        break;
      case 8:
        rst = "août";
        break;
      case 9:
        rst = 'septembre';
        break;
      case 10:
        rst = 'octobre';
        break;
      case 11:
        rst = 'novembre';
        break;
      case 12:
        rst = 'décembre';
        break;
    }
    return rst;
  }

  static getShortMonth(month){
    String rst="";
    switch (month){
      case 1:
        rst = "janv.";
        break;
      case 2:
        rst = "fév.";
        break;
      case 3:
        rst = "mars";
        break;
      case 4:
        rst = 'avril';
        break;
      case 5:
        rst = 'mai';
        break;
      case 6:
        rst = "juin";
        break;
      case 7:
        rst = "juil.";
        break;
      case 8:
        rst = "août";
        break;
      case 9:
        rst = 'sept.';
        break;
      case 10:
        rst = 'oct.';
        break;
      case 11:
        rst = 'nov.';
        break;
      case 12:
        rst = 'déc.';
        break;
    }
    return rst;
  }

  static getDisplayDate(String dateDebut, String dateFin){

    DateTime datedebut = DateTime.parse(dateDebut).toUtc().add(new Duration(hours: 1));
    DateTime datefin = DateTime.parse(dateFin).toUtc().add(new Duration(hours: 1));
    String rst;

    if(datefin == null){ // If the date is not sure
      if(datedebut.month == 1 && datedebut.day == 1){ //Year Only
        rst = datedebut.year.toString();
      }
      else{ // Year an month
        rst = getFullMonth(datedebut.month) + " " + datedebut.year;
      }
    }
    else{// Le jour exacte de debut et de fin
      if(datedebut.year != datefin.year){ //Sur deux ans
        rst = datedebut.day.toString().padLeft(2, "0") + ' ' + getShortMonth(datedebut.month)+ ' ' + datedebut.year.toString()+
        ' - '  + datefin.day.toString().padLeft(2, "0") + ' ' + getShortMonth(datefin.month)+ ' ' + datefin.year.toString();
      }
      else if(datedebut.month != datefin.month){//Sur deux mois
        rst = datedebut.day.toString().padLeft(2, "0") + " " + getShortMonth(datedebut.month) + "-" +
              datefin.day.toString().padLeft(2, "0") + " " + getShortMonth(datefin.month) + " " + datefin.year.toString();
      }
      else if(datedebut.day != datefin.day){//Sur plusieur jours
        rst = datedebut.day.toString().padLeft(2, "0") + "-" + datefin.day.toString().padLeft(2, "0") + " " + getFullMonth(datefin.month) + " " + datefin.year.toString();
      }
      else{//only 1 day
        rst = datefin.day.toString().padLeft(2, "0") + " " + getFullMonth(datefin.month) + " " + datefin.year.toString();
      }
    }

    return rst;
  }

}