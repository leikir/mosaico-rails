var lang = 'en';

var rcvmessage = function(evt) {
  if (evt.origin !== 'http://localhost:3001') {
    return;
  }
  if (JSON.parse(evt.data).type !== 'lang') {
    return;
  }
  lang = JSON.parse(evt.data).lang;
  init();
};

if (window.addEventListener) {
  window.addEventListener('message', rcvmessage, false);
} else {
  window.attachEvent('onmessage', rcvmessage);
}

function init() {
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

  var strings = $.ajax('rails_mosaico/lang/mosaico-' + lang + '.json', {type: 'GET', async: false}).responseText;
  strings = $.parseJSON(strings);


  plugins = [function(vm) {
    window.viewModel = vm;
  },
  function(vm) {
    if (strings) {
      vm.ut = function(key, objParam) {
        var res = strings[objParam]
        if (typeof res == 'undefined') {
          res = objParam;
        }
        return res;
      }
    }
  }
];

  Mosaico.init = function(options, customExtensions) {

    // Hash usage has been commented because we don't need it right now

    //var hash = global.location.hash ? global.location.href.split("#")[1] : undefined;

    // Loading from configured template or configured metadata
    if (options && (options.template || options.data)) {
      if (options.data) {
        var data = JSON.parse(options.data);
        Mosaico.start(options, undefined, JSON.parse(data.metadata), JSON.parse(data.content), customExtensions);
      } else {
        Mosaico.start(options, options.template, undefined, undefined, customExtensions);
      }
    }
      // Loading from LocalStorage (if url hash has a 7chars key)
    // } else if (hash && hash.length == 7) {
    //   initFromLocalStorage(options, hash, customExtensions);
    //   // Loading from template url as hash (if hash is not a valid localstorage key)
    // } else if (hash) {
    //   start(options, _canonicalize(hash), undefined, undefined, customExtensions);
    // }
    else {
      return false;
    }
    return true;
  }

  var ok = Mosaico.init({
    strings: strings,
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
};
