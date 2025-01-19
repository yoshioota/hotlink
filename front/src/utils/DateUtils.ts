import { format } from 'date-fns'

export class DateUtils {
  static localYMDHMS(datetime: string): string {
    return format(datetime, 'yyyy-MM-dd HH:mm:ss')
  }
}
