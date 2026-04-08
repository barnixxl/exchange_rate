String formatDate(DateTime date) {
  return ''
      '${date.day}'
      ' ${getMonthName(date.month)}'
      ' ${date.year},'
      ' ${date.hour}:'
      '${date.minute.toString().padLeft(2, '0')}'
      '';
}

String getMonthName(int month) {
  const months = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря'
  ];
  return months[month - 1];
}
