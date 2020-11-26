abstract class MvpView {
  showLoading();

  showLoadingWithMessage(String message);

  showError(bool isReload);

  showErrorWithMessage(String message,bool isReload);

  showMessage(String message);

  showProgressDialog(String message);

  hideProgressDialog();
}
