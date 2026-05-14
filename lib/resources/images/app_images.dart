class AppImages {
  static const String usd = 'assets/images/usd.png';
  static const String eur = 'assets/images/eur.png';
  static const String cny = 'assets/images/cny.png';
  static const String pln = 'assets/images/pln.png';
  static const String uah = 'assets/images/uah.png';

  static String forCode(String code){
    switch(code){
      case 'USD': return usd;
      case 'EUR': return eur;
      case 'CNY': return cny;
      case 'PLN': return pln;
      case 'UAH': return uah;
      default: return usd;
    }
  }
}