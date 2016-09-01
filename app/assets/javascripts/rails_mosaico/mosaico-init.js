var lang = 'en';
var metadatas;
var content;
var initFromTpl = false;
var tplReceived = false;
var initReceived = false;

var rcvmessage = function(evt) {
  if (JSON.parse(evt.data).type === 'init') {
    lang = JSON.parse(evt.data).lang;
    initFromTpl = JSON.parse(evt.data).fromTpl;
    initReceived = true;
  }
  else if (JSON.parse(evt.data).type === 'savedTpl' && initFromTpl === true) {
    metadatas = JSON.parse(evt.data).datas.metadatas;
    content = JSON.parse(evt.data).datas.content;
    tplReceived = true;
  }
  else if (JSON.parse(evt.data).type === 'css') {
    var elems = JSON.parse(evt.data).elems;
    var style = JSON.parse(evt.data).style;

    for (var i = 0; i < elems.length; i++) {
      $(elems[i]).css(style[i]);
    }
  }

  if (JSON.parse(evt.data).type === 'init' || JSON.parse(evt.data).type === 'savedTpl') {
    if ((initFromTpl === true && tplReceived === true && !(metadatas && content)) || initReceived === false) {
      console.warn('You did not sent metadatas and content as expected');
      return;
    }
    else if (((initFromTpl === true && tplReceived === true) || (initFromTpl === false)) && initReceived === true) {
      init();
    }
  }
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
    data: JSON.stringify({
      metadata: metadatas,
      content: content
    }),
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
