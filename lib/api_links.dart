class ApiLinks {
  //! server link
  static const String server = "http://192.168.1.3:3000";

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
  //? add products to user cart
  static const addToCart = "$server/api/addtocart";
  static const removeFromCart = "$server/api/removefromcart";
  //? add user address
  static const addUserAddress = "$server/api/adduseraddress";
  //? place user order
  static const placeOrder = "$server/api/order";
  //? get user orders
  static const getOrders = "$server/api/getorders";
  //? get all users orders for admin
  static const getAllUserOrders = "$server/admin/getallorders";
  static const changeOrderStatus = "$server/admin/changeorderstatus";
  static const getAnalyticsEarings = "$server/admin/analytics";
}
