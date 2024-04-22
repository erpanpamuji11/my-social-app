class BaseUrl {
  String url = "dummyapi.io/data/v1";
  // String url = "panasonic.trial.ragdalion.com";

  // String url = "103.193.177.58:3030";

  String getUrlDevice() {
    return 'http://$url';
  }

  String getWsDevice() {
    return 'ws://$url/ws';
  }
}
