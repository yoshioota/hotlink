'use client'

import { apolloClient } from '@/lib/apolloClient'
import { ApolloProvider } from '@apollo/client'
import './globals.css'

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <ApolloProvider client={apolloClient}>
      <html>
        <head>
          <meta name='format-detection' content='telephone=no' />
        </head>
        <body>{children}</body>
      </html>
    </ApolloProvider>
  )
}
