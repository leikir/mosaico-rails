var lang = 'en';

// var rcvmessage = function(evt) {
//   if (evt.origin !== 'http://localhost:3001') {
//     return;
//   }
//   if (JSON.parse(evt.data).type !== 'lang') {
//     return;
//   }
//   lang = JSON.parse(evt.data).lang;
//   init();
// };
//
// if (window.addEventListener) {
//   window.addEventListener('message', rcvmessage, false);
// } else {
//   window.attachEvent('onmessage', rcvmessage);
// }

$(function init() {
  if (!Mosaico.isCompatible()) {
    alert('Update your browser!');
    return;
  }
  // var basePath = window.location.href.substr(0, window.location.href.lastIndexOf('/')).substr(window.location.href.indexOf('/','https://'.length));
  var basePath = window.location.href;
  if (basePath.lastIndexOf('#') > 0) basePath = basePath.substr(0, basePath.lastIndexOf('#'));
  if (basePath.lastIndexOf('?') > 0) basePath = basePath.substr(0, basePath.lastIndexOf('?'));
  if (basePath.lastIndexOf('/') > 0) basePath = basePath.substr(0, basePath.lastIndexOf('/'));

  var plugins;
  // A basic plugin that expose the "viewModel" object as a global variable.
  // var strings = $.ajax('dist/lang/mosaico-' + lang + '.json', {type: 'GET', async: false}).responseText;
  // strings = $.parseJSON(strings);


  plugins = [function(vm) {
    window.viewModel = vm;
  }
  // function(vm) {
  //   if (strings) {
  //     vm.ut = function(key, objParam) {
  //       var res = strings[objParam]
  //       if (typeof res == 'undefined') {
  //         console.warn("Missing translation string for",key,": using default string");
  //         res = objParam;
  //       }
  //       return res;
  //     }
  //   }
  // }
];

  var ok = Mosaico.init({
    //strings: strings,
    imgProcessorBackend: basePath+'/img/',
    emailProcessorBackend: basePath+'/dl/',
    titleToken: "MOSAICO Responsive Email Designer",
    // data: JSON.stringify({
    //   metadata: window.localStorage['metadata-ubqg77j'],
    //   content: window.localStorage['template-ubqg77j']
    // }),
    template: "/versafix-1/template-versafix-1.html",
    fileuploadConfig: {
      url: basePath+'/upload/',
      // messages??
    }
  }, plugins);
  if (!ok) {
    console.log("Missing initialization hash, redirecting to main entrypoint");
    document.location = ".";
  }
});
