import Link from 'next/link'

export default function Home() {
  return (
    <div className={'p-20'}>
      <div className={'flex justify-center text-3xl'}>
        <Link href='/links' className={'text-blue-500'}>
          Links
        </Link>
      </div>
    </div>
  )
}
