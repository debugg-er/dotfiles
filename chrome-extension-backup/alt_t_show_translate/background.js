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

async function focusTranslatePopup() {
  return new Promise((resolve, reject) => {
    chrome.windows.getAll((windows) => {
      const popup = windows.find(
        (window) => window.height == 300 && window.type == 'popup',
      );
      console.log(windows)

      if (!popup) {
        return reject();
      }

      windowId = popup.id;
      chrome.windows.update(popup.id, { focused: true }, resolve);
    });
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
      await focusWindow(windowId)
      return;
    } catch (_e1) {
      try {
        await focusTranslatePopup();
        return;
      } catch (_e2) {}
    }
  }

  windowId = await popupGGTranslate();
});