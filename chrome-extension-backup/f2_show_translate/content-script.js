window.addEventListener('keydown', (key) => {
  if (key.key == 'F2') {
    chrome.runtime.sendMessage('open');
  }
});
