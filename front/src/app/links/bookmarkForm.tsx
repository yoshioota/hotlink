import { useEffect } from 'react'
import { useForm } from 'react-hook-form'
import { z } from 'zod'
import { zodResolver } from '@hookform/resolvers/zod'

const bookmarkFormSchema = z.object({
  url: z.string().url({ message: 'URL形式にしてください' }),
  title: z.string().max(255, { message: '255文字以下にしてください' }),
})

// NOTE: schemaから型を生成
export type BookmarkFormValues = z.infer<typeof bookmarkFormSchema>

export const BookmarkForm = ({
  formValues,
  onSubmit,
}: {
  formValues: BookmarkFormValues
  onSubmit: (values: BookmarkFormValues) => void
}) => {
  const form = useForm<BookmarkFormValues>({
    resolver: zodResolver(bookmarkFormSchema),
  })
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = form

  useEffect(() => {
    reset(formValues)
  }, [formValues])

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div className={'my-1'}>
        <label className={'font-bold'}>Url</label>
        <input {...register('url')} className={'block border'} />
        {errors.url?.message && <div className={'text-red-500'}>{errors.url.message}</div>}
      </div>

      <div className={'my-1'}>
        <label className={'font-bold'}>Title</label>
        <input {...register('title')} className={'block border'} />
        {errors.title?.message && <div className={'text-red-500'}>{errors.title.message}</div>}
      </div>

      <button type={'submit'} className={'border p-1'}>
        Save
      </button>
    </form>
  )
}
