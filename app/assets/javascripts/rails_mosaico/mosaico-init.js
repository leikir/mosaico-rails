var locale = 'en';
var metadatas;
var content;
var initFromTpl = false;
var tplReceived = false;
var initReceived = false;

var rcvmessage = function(evt) {

  var data = JSON.parse(evt.data);

  if (data.type === 'init') {
    locale = data.locale;
    initFromTpl = data.fromTpl;
    initReceived = true;
    if (initFromTpl === true) {
      if (!data.metadatas || !data.content) {
        console.warn('You did not sent metadatas and content as expected');
        return;
      }
      metadatas = data.metadatas;
      content = data.content;
    }
  }
  else if (data.type === 'loadContent' && initFromTpl === true) {
    metadatas = data.datas.metadatas;
    content = data.datas.content;
    tplReceived = true;
  }
  else if (data.type === 'css') {
    var elems = data.elems;
    var style = data.style;

    for (var i = 0; i < elems.length; i++) {
      $(elems[i]).css(style[i]);
    }
    return;
  }
  if (initReceived === true) {
    if ((initFromTpl === true && metadatas && content) || initFromTpl === false) {
      init();
    }
    else if (initFromTpl === true) {
      return;
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

  var strings = $.ajax('rails_mosaico/lang/mosaico-' + locale + '.json', {type: 'GET', async: false}).responseText;
  strings = $.parseJSON(strings);


  plugins = [
    function(vm) {
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

  var ok = Mosaico.init({
    strings: strings,
    imgProcessorBackend: basePath+'/img/',
    emailProcessorBackend: basePath+'/dl/',
    titleToken: "MOSAICO Responsive Email Designer",
    data: JSON.stringify({
      metadata: JSON.parse(metadatas),
      content: JSON.parse(content)
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
