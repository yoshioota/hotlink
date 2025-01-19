// NOTE: TODO: どっかに設定を入れる
const endpointUrl = 'http://192.168.1.139:5005/graphql'

chrome.action.onClicked.addListener((tab) => {
  if (tab.url?.includes('chrome://')) return

  const input = {
    url: tab.url,
    title: tab.title,
    faviconUrl: tab.favIconUrl,
  }

  fetch(endpointUrl, {
    method: 'POST',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      query: `
        mutation BookmarkSave($input: BookmarkSaveInput!) {
          bookmarkSave(input: $input) {
            id
          }
        }
      `,
      variables: { input },
    }),
  }).then((_) => {})
})
