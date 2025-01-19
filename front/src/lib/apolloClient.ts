import { ApolloClient, InMemoryCache } from '@apollo/client'

const uri = `${process.env.NEXT_PUBLIC_BACKEND_URL}/graphql`

export const apolloClient = new ApolloClient({
  uri,
  cache: new InMemoryCache(),
  // NOTE: cacheしない
  defaultOptions: {
    watchQuery: {
      fetchPolicy: 'no-cache',
      errorPolicy: 'all',
    },
    query: {
      fetchPolicy: 'no-cache',
      errorPolicy: 'all',
    },
  },
})
