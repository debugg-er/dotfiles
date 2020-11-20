function getStorage() {
  return new Promise((resolve, reject) => {
    chrome.storage.local.get(null, (data) => {
      resolve(data);
    });
  });
}

function setStorage(data) {
  return new Promise((resolve, reject) => {
    chrome.storage.local.set(data, resolve);
  });
}

function popupGGTranslate() {
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
        reject(chrome.runtime.lastError.message);
      } else {
        resolve();
      }
    });
  });
}

chrome.commands.onCommand.addListener(async function () {
  const store = await getStorage();

  if (store.windowId) {
    try {
      await focusWindow(store.windowId);
      return;
    } catch (err) {
      console.log(err);
    }
  }

  const windowId = await popupGGTranslate();

  await setStorage({ windowId });
});
