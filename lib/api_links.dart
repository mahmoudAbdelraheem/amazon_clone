class ApiLinks {
  //! server link
  static const String server = "http://192.168.1.6:3000";

  //! auth links
  static const signUp = "$server/api/signup";
  static const signIn = "$server/api/signin";
  static const vaildToken = "$server/api/tokenIsValid";
  static const getUserData = "$server/";
  //? products links
  static const addProduct = "$server/admin/addproduct";
  static const getProducts = "$server/admin/getproducts";
  static const deleteProduct = "$server/admin/deleteproduct";
  //? get products by category name
  static const getProductsByCategory = "$server/api/products";
  //? search api
  static const searchProducts = "$server/api/products/search";
  //? rating product
  static const ratingProduct = "$server/api/ratingproduct";
  //? get deal of the day products
  static const dealOfDay = "$server/api/dealofday";
}
