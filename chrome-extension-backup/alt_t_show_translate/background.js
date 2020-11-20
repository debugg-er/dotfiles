let windowId = null;

async function popupGGTranslate() {
  return new Promise((resolve) => {
    chrome.windows.create(
      {
        url: 'https://translate.google.com',
        type: 'popup',
        focused: true,
        height: 300,
        width: 950,
      },
      (window) => {
        resolve(window.id);
      },
    );
  });
}

async function focusWindow(windowId) {
  return new Promise((resolve, reject) => {
    chrome.windows.update(windowId, { focused: true }, () => {
      if (chrome.runtime.lastError) {
        reject(chrome.runtime.lastError.message)
      } else {
        resolve();
      }
    });
  })
}

chrome.commands.onCommand.addListener(async function () {
  if (windowId !== null) {
    try {
      await focusWindow(windowId);
      return;
    } catch (err) { }
  }

  windowId = await popupGGTranslate();
});