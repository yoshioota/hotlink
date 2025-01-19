'use client'

import { BookmarkTable, DEFAULT_BOOKMARK_COLOR } from './bookmarkTable'
import {
  archiveBookmarkMutation,
  bookmarksQuery,
  deleteBookmarkMutation,
  updateBookmarkMutation,
} from './query'
import { Button } from '@/components/ui/button'
import { loadCreateConsumer } from '@/lib/actionCable'
import { ACTION_CABLE_ENDPOINT } from '@/lib/consts'
import { useLazyQuery, useMutation } from '@apollo/client'
import Link from 'next/link'
import { useEffect, useState } from 'react'

const ARCHIVE_TYPE_UNARCHIVED = 1
const ARCHIVE_TYPE_ARCHIVED = 2
const ARCHIVE_TYPE_BOTH = 3

export default function Page() {
  const [consumer, setConsumer] = useState<any>()
  const [subscription, setSubscription] = useState<any>()
  const [deleteBookmarkMutationFunk] = useMutation(deleteBookmarkMutation)
  const [archiveBookmarkMutationFunc] = useMutation(archiveBookmarkMutation)
  const [updateBookmarkMutationFunc] = useMutation(updateBookmarkMutation)
  const [fetchData, { data, refetch }] = useLazyQuery(bookmarksQuery)

  const [bookmarkColorId, setBookmarkColorId] = useState<string>('')

  const [archiveType, setArchiveType] = useState<number>(ARCHIVE_TYPE_UNARCHIVED)
  const [showUrl, setShowUrl] = useState<boolean>(false)
  const [bookmarkColors, setBookmarkColors] = useState<any[]>([])
  const [bookmarks, setBookmarks] = useState<any[]>([])

  useEffect(() => {
    if (typeof window === 'undefined') return

    loadCreateConsumer().then((createConsumer) => {
      setConsumer(createConsumer(ACTION_CABLE_ENDPOINT))
    })
  }, [typeof window])

  useEffect(() => {
    if (!consumer) return

    setSubscription(
      consumer.subscriptions.create('BookmarkChannel', {
        appear: () => console.log('appear'),
        away: () => console.log('away'),
        connected: () => console.log('connected'),
        disconnected: () => console.log('disconnected'),
        initialized: () => console.log('initialized'),
        install: () => console.log('install'),
        rejected: () => console.log('rejected'),
        uninstall: () => console.log('uninstall'),
        update: () => console.log('update'),
        received: (data: any) => {
          refetch()
        },
      }),
    )
  }, [consumer])

  useEffect(() => {
    let wheres: any[] = []
    let orders: any[] = [
      ['order_by_bookmark_color'],
      // ['url', 'asc'],
      ['created_at', 'desc'],
    ]

    switch (archiveType) {
      case ARCHIVE_TYPE_UNARCHIVED:
        wheres.push({ field_name: 'archived', op: 'in', value: [false] })
        break
      case ARCHIVE_TYPE_BOTH:
        wheres.push({ field_name: 'archived', op: 'in', value: [true, false] })
        break
      case ARCHIVE_TYPE_ARCHIVED:
        wheres.push({ field_name: 'archived', op: 'in', value: [true] })
        break
    }

    switch (bookmarkColorId) {
      case '':
        break
      default:
        wheres.push({
          field_name: 'filter_by_bookmark_color_id',
          value: bookmarkColorId,
        })
    }

    fetchData({
      variables: { wheres, orders },
    }).then((resp) => {
      setBookmarks(resp.data.bookmarks)
    })
  }, [archiveType, bookmarkColorId])

  useEffect(() => {
    if (data) {
      setBookmarks(data.bookmarks)
      setBookmarkColors(data.bookmarkColors)
    }
  }, [data])

  const deleteBookmark = (bookmark: any) => {
    deleteBookmarkMutationFunk({
      variables: { input: { id: bookmark.id } },
    }).then((resp) => {
      refetch()
    })
  }

  const updateBookmarkColor = (bookmark: any, bookmarkColorId: number) => {
    updateBookmarkMutationFunc({
      variables: {
        input: {
          id: bookmark.id,
          title: bookmark.title,
          url: bookmark.url,
          bookmarkColorId,
        },
      },
    }).then((resp) => {
      refetch()
    })
  }

  const refetchBookmark = () => {
    refetch()
  }

  const archiveBookmark = (bookmark: any) => {
    archiveBookmarkMutationFunc({
      variables: { input: { id: bookmark.id } },
    }).then((resp) => {
      refetch()
    })
  }

  const handleArchiveTypeChanged = (e: any) => {
    setArchiveType(Number(e.target.value))
  }

  const handleColorTypeChanged = (e: any) => {
    setBookmarkColorId(e.target.value)
  }

  return (
    <div className='px-2'>
      <div className={'my-5 flex justify-end gap-x-3'}>
        <Button variant={'outline'} size={'sm'} onClick={refetchBookmark}>
          Reload
        </Button>
        <Link href={'/links/new'}>
          <Button size={'sm'}>+</Button>
        </Link>
      </div>

      <div>
        <div className={'mb-5 flex justify-between gap-x-2'}>
          <div className={'flex gap-x-2'}>
            <select
              value={archiveType}
              onChange={handleArchiveTypeChanged}
              className={'border px-1'}
            >
              <option value={ARCHIVE_TYPE_UNARCHIVED}>UnArchived</option>
              <option value={ARCHIVE_TYPE_ARCHIVED}>Archived</option>
              <option value={ARCHIVE_TYPE_BOTH}>Both</option>
            </select>

            <select
              value={bookmarkColorId}
              onChange={handleColorTypeChanged}
              className={'min-w-16 border px-1'}
            >
              {[DEFAULT_BOOKMARK_COLOR, ...bookmarkColors].map((bookmarkColor) => {
                return (
                  <option key={bookmarkColor.id} value={bookmarkColor.id}>
                    {bookmarkColor.name}
                  </option>
                )
              })}
            </select>
          </div>
          <div>
            <label className={'items-top flex cursor-pointer select-none gap-x-1'}>
              <input
                type={'checkbox'}
                checked={showUrl}
                onChange={(e) => {
                  setShowUrl(e.target.checked)
                }}
              />
              <span>Url</span>
            </label>
          </div>
        </div>

        <BookmarkTable
          bookmarks={bookmarks}
          showUrl={showUrl}
          archiveBookmark={archiveBookmark}
          deleteBookmark={deleteBookmark}
          updateBookmarkColor={updateBookmarkColor}
          bookmarkColors={bookmarkColors}
        />
      </div>
    </div>
  )
}
