class ConfigAPI {
  //Example: https://www.example.com without /
  static const String baseUrl = 'https://nifty-diet-adb2127174f3.herokuapp.com';
  static const String baseApiUrl = '$baseUrl/api';
  // static const stripePublishableKey =  "pk_test_51Lx4u5Lv66vTYu5L1v1BnJLM7AKDlwjGblIWAKR5Cmv2bhf45NHCbWlDWWVQ6BlDr6Cu24EsviLE1sTP60tVaId400DGESVSo1";
  static const stripePublishableKey =  "pk_live_51Lx4u5Lv66vTYu5LJpj4iHBOcUZn1k8mcASE0zqZznp0Rx5zswEqNCdqNwuBcNb6a10jhpj4w811y9OlpZo5kQuw006SzFlGDV";

  static const int sessionTimeoutThreshold =
  0; // Will refresh the access token 5 minutes before it expires
  static const bool loginWithPassword = true; // if false hide the form login
  //if false hide the fields password and confirm password from signup form
  //for security reason and the password generated after verification mail
  static const bool signupWithPassword = true;

  static const String signInUrl = '/auth/local';
  static const String signUpUrl = '/auth/local/register';
  static const String changePasswordUrl = '/auth/change-password';
  static const String meUrl = '/users/me';
  static const String ingredientsUrl = '/ingredients';
  static const String subCategoriesUrl = '/sub-categories';
  static const String categoriesUrl = '/categories';
  static const String recipesUrl = '/recipes';
  static const String dailyUrl = '/dailies';
  static const String sportUrl = '/sports';
  static const String historyUrl = '/histories';


  //subscription apis
  static const String createProductCheckoutSessionUrl = '/createProductCheckoutSession';
  static const String retrieveCheckoutSessionUrl = '/retrieveCheckoutSession';
  static const String createCustomerPortalSession = '/createCustomerPortalSession';
  static const String deleteMyData = '/deleteMyData';
  static const String sendConfirmationEmail = '/sendConfirmationEmail';

  static const String getSubscriptionsPlans = '/getSubscriptionsPlans';
  static const String verifyAppleReceipt = '/verifyAppleReceipt';

}