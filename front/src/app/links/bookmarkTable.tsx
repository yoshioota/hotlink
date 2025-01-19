
import { ArchiveIcon, TrashIcon } from '@radix-ui/react-icons'
import Link from 'next/link'
import {Button} from "@/components/ui/button";

export const DEFAULT_BOOKMARK_COLOR = { id: '', value: '', name: '' }

export const BookmarkTable = ({
  bookmarks,
  showUrl,
  archiveBookmark,
  deleteBookmark,
  updateBookmarkColor,
  bookmarkColors,
}: any) => {
  return (
    <table className={'w-full [&_td]:border'}>
      <tbody>
        {bookmarks.map((bookmark: any) => {
          const bookmarkColor = bookmarkColors.find(
            (v: any) =>
              v.id === bookmark.bookmarksBookmarkColor?.bookmarkColorId
          )

          const backgroundColor = bookmarkColor?.css
            ? bookmarkColor.css
            : 'inherit'

          return (
            <tr
              key={bookmark.id}
              className={`border even:bg-gray-50/50 hover:!bg-yellow-50`}
              style={{ backgroundColor }}
            >
              <td className={'w-11/12 px-1.5'}>
                <div className={'font-bold'}>
                  <Link
                    href={bookmark.url}
                    target={'_blank'}
                    className={'block'}
                  >
                    <img
                      src={bookmark.faviconUrl}
                      alt={bookmark.title}
                      width={16}
                      height={16}
                      className={'mr-2 inline'}
                    />
                    {bookmark.title}
                  </Link>
                </div>
                {showUrl && (
                  <div className={'break-all pb-1 text-sm text-gray-500'}>
                    {bookmark.url}
                  </div>
                )}
              </td>
              {false && (
                <td>
                  <Link href={`/projects/${bookmark.id}/edit`}>
                    <Button variant={'outline'} size={'sm'}>
                      Edit
                    </Button>
                  </Link>
                </td>
              )}
              <td>
                {bookmark.archived ? (
                  <div className={'text-center text-gray-200'}>Archived</div>
                ) : (
                  <Button
                    variant={'outline'}
                    size={'xs'}
                    onClick={() => archiveBookmark(bookmark)}
                  >
                    <ArchiveIcon />
                  </Button>
                )}
              </td>
              <td>
                <Button
                  variant={'destructiveOutline'}
                  onClick={() => deleteBookmark(bookmark)}
                  size={'xs'}
                >
                  <TrashIcon />
                </Button>
              </td>
              <td>
                <select
                  className={'border py-0.5'}
                  value={bookmark.bookmarksBookmarkColor?.bookmarkColorId || ''}
                  onChange={(e) => {
                    updateBookmarkColor(bookmark, parseInt(e.target.value))
                  }}
                >
                  {bookmarkColors.map((bookmarkColor: any) => {
                    return (
                      <option key={bookmarkColor.id} value={bookmarkColor.id}>
                        {bookmarkColor.name}
                      </option>
                    )
                  })}
                </select>
              </td>
            </tr>
          )
        })}
      </tbody>
    </table>
  )
}
