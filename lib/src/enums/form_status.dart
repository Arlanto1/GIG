enum FormStatus {
  loading,
  initial,
  submitting,
  addAttachment,
  next,
  success,
  successFormSubmit,
  failure,
  formError,  // Form Validation Erro
  error,  // Immediately Logout
  permissionLocationError, // When location Permission is denied
  invalidEmail,
  addArticleFound,
  navigateToNextScreen, // Navigate to Next Screen
  sessionExpired, // Token Expired
  popOnly,
  sendEmail
}
