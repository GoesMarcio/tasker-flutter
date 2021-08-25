String monthName(month) {
  switch (month) {
    case 1:
      return "janeiro";
    case 2:
      return "fevereiro";
    case 3:
      return "março";
    case 4:
      return "abril";
    case 5:
      return "maio";
    case 6:
      return "junho";
    case 7:
      return "julho";
    case 8:
      return "agosto";
    case 9:
      return "setembro";
    case 10:
      return "outubro";
    case 11:
      return "novembro";
    case 12:
      return "dezembro";
    default:
      return "";
  }
}

String showDate(date) {
  var datenow = new DateTime.now();

  var dayDisplay =
      "${date.day.toString().padLeft(2, '0')} de ${monthName(date.month)}";

  var dayCompare =
      "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

  var dayNow =
      "${datenow.day.toString().padLeft(2, '0')}/${datenow.month.toString().padLeft(2, '0')}/${datenow.year}";
  var dayTomorow =
      "${(datenow.day + 1).toString().padLeft(2, '0')}/${datenow.month.toString().padLeft(2, '0')}/${datenow.year}";

  if (datenow.year != date.year) {
    dayDisplay += " de ${date.year}";
  } else {
    dayDisplay +=
        " às ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  if (dayCompare == dayNow) {
    dayDisplay = "Hoje às ${date.hour}:${date.minute}";
  }

  if (dayCompare == dayTomorow) {
    dayDisplay = "Amanhã às ${date.hour}:${date.minute}";
  }

  return dayDisplay;
}

String dateToString(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

String timeToString(DateTime date) {
  return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:00";
}

String stringToday() {
  var datenow = new DateTime.now();

  switch (datenow.weekday) {
    case 1:
      return "Segunda-feira";
    case 2:
      return "Terça-feira";
    case 3:
      return "Quarta-feira";
    case 4:
      return "Quinta-feira";
    case 5:
      return "Sexta-feira";
    case 6:
      return "Sábado";
    case 7:
      return "Domingo";
    default:
      return "a";
  }
}

String stringDate() {
  var datenow = new DateTime.now();

  return "${datenow.day.toString().padLeft(2, '0')} de ${monthName(datenow.month)} de ${datenow.year}";
}
