import gql from 'graphql-tag'

export const bookmarksQuery = gql`
  query ($wheres: [JSON!], $orders: [JSON!]) {
    bookmarks(wheres: $wheres, orders: $orders) {
      id
      title
      url
      faviconUrl
      archived

      bookmarksBookmarkColor {
        bookmarkColorId
      }
    }

    bookmarkColors {
      id
      name
      position
      css
    }
  }
`

export const deleteBookmarkMutation = gql`
  mutation ($input: BookmarkDeleteInput!) {
    bookmarkDelete(input: $input)
  }
`

export const archiveBookmarkMutation = gql`
  mutation ($input: BookmarkArchiveInput!) {
    bookmarkArchive(input: $input)
  }
`

export const updateBookmarkMutation = gql`
  mutation ($input: BookmarkUpdateInput!) {
    bookmarkUpdate(input: $input) {
      id
    }
  }
`
