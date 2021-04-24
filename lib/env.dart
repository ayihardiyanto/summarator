const bool isProduction = bool.fromEnvironment('dart.vm.product');
const prodConfig = {};
const devConfig = {};
const environment = isProduction ? prodConfig : devConfig;
