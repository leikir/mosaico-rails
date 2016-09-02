(function() {
  var strings;

  // var basePath = window.location.href.substr(0, window.location.href.lastIndexOf('/')).substr(window.location.href.indexOf('/','https://'.length));
  var basePath = window.location.href;
  if (basePath.lastIndexOf('/') > 0) basePath = basePath.substr(0, basePath.lastIndexOf('/'));

  var plugins;
  // A basic plugin that expose the "viewModel" object as a global variable.


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

  var initOptions = {
    imgProcessorBackend: basePath+'/img/',
    emailProcessorBackend: basePath+'/dl/',
    titleToken: "MOSAICO Responsive Email Designer",
    template: "/versafix-1/template-versafix-1.html",
    fileuploadConfig: {
      url: basePath+'/upload/',
      // messages??
    }
  };

  var rcvmessage = function(evt) {


    var data = JSON.parse(evt.data);

    switch (data.action) {
      case 'init':
        if (data.locale) {
          strings = $.ajax('rails_mosaico/lang/mosaico-' + data.locale + '.json', {type: 'GET', async: false}).responseText;
          initOptions.strings = $.parseJSON(strings);
        }
        if (data.metadata && data.content) {
          initOptions['data'] = JSON.stringify({
            metadata: JSON.parse(data.metadata),
            content: JSON.parse(data.content)
          });
        }
        init();
        break;
      case 'loadContent':
        initOptions['data'] = JSON.stringify({
          metadata: JSON.parse(data.datas.metadata),
          content: JSON.parse(data.datas.metadata)
        });
        init();
        break;
      case 'css':
        var elems = data.elems;
        var style = data.style;

        for (var i = 0; i < elems.length; i++) {
          $(elems[i]).css(style[i]);
        }
        break;
      case 'exportReq':
        top.postMessage(JSON.stringify({
          type: 'exportHTML',
          htmlContent: window.viewModel.exportHTML(),
          jsonContent: window.viewModel.exportJSON(),
          jsonMetadata: window.viewModel.exportMetadata()
        }), '*');
        break;
      default:
        console.info(data.action + ' is not recognized as an action');
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

    Mosaico.init(initOptions);
  }
})()
