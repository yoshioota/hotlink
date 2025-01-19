import gql from 'graphql-tag'

export const bookmarkCreateMutation = gql`
  mutation ($input: BookmarkCreateInput!) {
    bookmarkCreate(input: $input) {
      id
    }
  }
`
