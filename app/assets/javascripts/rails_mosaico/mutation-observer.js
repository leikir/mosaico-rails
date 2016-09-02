MutationObserver = window.MutationObserver || window.WebKitMutationObserver;

var templateLoaded = false;
var toObserve = document.body;

// First we check when the template has loaded, then we watch its changes
var observer = new MutationObserver(function(mutations, observer) {
  if (templateLoaded === false && mutations.length > 1) {
    templateLoaded = true;
    toObserve = document.getElementById('main-wysiwyg-area');
    console.log(window.viewModel.exportHTML());
    top.postMessage(window.viewModel.exportHTML(), '*');
  }
  // if (templateLoaded === true) {
  //   top.postMessage(window.viewModel.exportHTML(), orig);
  // }
});

observer.observe(toObserve, {
  subtree: true,
  attributes: false,
  characterData: true
});
