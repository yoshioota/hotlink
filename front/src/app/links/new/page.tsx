'use client'

import { BookmarkForm, BookmarkFormValues } from '../bookmarkForm'
import { bookmarkCreateMutation } from './query'
import { useMutation } from '@apollo/client'
import Link from 'next/link'
import { useState } from 'react'

export default function Page() {
  const [createBookmarkMutation] = useMutation(bookmarkCreateMutation)
  const [formValues] = useState<BookmarkFormValues>({
    url: '',
    title: '',
  })

  const onSubmit = (values: BookmarkFormValues) => {
    createBookmarkMutation({
      variables: {
        input: {
          url: values.url,
          title: values.title,
        },
      },
    })
      .then(() => {
        alert('ok')
      })
      .catch((mutationErrors) => {
        alert(mutationErrors.message)
      })
  }

  return (
    <div className='mx-auto'>
      <div>
        <Link href={'/links'} className={'text-blue-500'}>
          Links
        </Link>
      </div>
      <div className={'flex justify-center mt-10'}>
        <BookmarkForm formValues={formValues} onSubmit={onSubmit} />
      </div>
    </div>
  )
}
