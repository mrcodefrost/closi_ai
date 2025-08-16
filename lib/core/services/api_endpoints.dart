class ApiEndpoints {
  static const baseUrl = "https://findesy.onrender.com"; // Dev
  // static const String baseUrl = "https://findesy.onrender.com"; // QA
  // static const String baseUrl = "https://findesy.onrender.com"; // Prod

  static const llmBaseUrl = "https://findesy-image-llm.onrender.com"; // Dev

  // Auth Endpoints
  static const google = "/auth/google";
  static const register = "/auth/register";
  static const updateUser = "/auth/updateuser";
  static const requestOtp = "/auth/login/request-otp";
  static const verifyOtp = "/auth/login/verify-otp";
  static const refreshToken = "/auth/refresh-token";
  // Ads Endpoints
  static const getAds = "/forms/getAds";
  static const createAd = "/forms/createAds";
  static const getAdById = "/forms/getAd/{id}";
  static const updateAd = "/forms/ad/{id}";
  static const deleteAd = "/forms/ad/{id}";

  // FormFields Endpoints
  static const getFormFields = "/forms/subcategories/{categoryId}/form-fields";
  static const createFormField =
      "/forms/subcategories/{categoryId}/form-fields";
  static const updateFormField = "/forms/form-fields/{id}";
  static const deleteFormField = "/forms/form-fields/{id}";

  // Subcategories Endpoints
  static const getSubcategories =
      "/forms/categories/{categoryId}/subcategories";
  static const createSubcategory =
      "/forms/categories/{categoryId}/subcategories";
  static const updateSubcategory = "/forms/subcategories/{id}";
  static const deleteSubcategory = "/forms/subcategories/{id}";

  // Categories Endpoints
  static const getCategories = "/forms/categories";
  static const createCategory = "/forms/categories";
  static const updateCategory = "/forms/categories/{id}";
  static const deleteCategory = "/forms/categories/{id}";

  // Analyze Grok Endpoints
  static const cartAnalyze = "/cart-analyze"; // Multiple items
  static const dynamicAnalyze = "/dynamic-analyze"; // Single item
}
