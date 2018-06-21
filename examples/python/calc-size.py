#!/usr/bin/python3
import sys
import os

def main():
  parser, options = parse_argv()
  if sys.stdin.isatty():
    print('Please use pipe')
    parser.print_help()
    sys.exit()

  print("\n========== [{}] ==========".format(now()))
  # Process stdin into list: files
  files = []
  for i in sys.stdin:
    i = i.rstrip()
    files.append(i)

  # Calculate max width
  width = len(max(files, key=len))
  format_str = '{:' + str(width) + 's}   {}'
  print('max width: ', width)

  # Print size of each file
  total_size = 0
  for filename in files:
    size = os.path.getsize(filename)
    if options.h:
      print(format_str.format(filename, size_format(size)))
    else:
      print(format_str.format(filename, size))
    total_size += size

  # Print final result
  if options.h:
    final_result= format_str.format('total size:', size_format(total_size))
  else:
    final_result= format_str.format('total size:', total_size)
  print('-' * len(final_result))
  print(final_result)

# __END___ {{{
import datetime
# ============================================================
# now() will return a iso-format time string of current time
#
# paramter: void
# return: string
# author: YC Su <hansycsu@gmail.com>
# ============================================================
def now():
  now = datetime.datetime.now()
  return now.replace(microsecond=0)

# ============================================================
# size_format() will return human-readable size format string
#
# paramter:
#   int num - size (in Byte)
#   char suffix - unit suffix (default: 'B')
# return: string - human-readable size format
# author: YC Su <hansycsu@gmail.com>
# ============================================================
def size_format(num, suffix='B'):
  for unit in ['','Ki','Mi','Gi','Ti','Pi','Ei','Zi']:
    if abs(num) < 1024.0:
      return "%3.1f%s%s" % (num, unit, suffix)
    num /= 1024.0
  return "%.1f%s%s" % (num, 'Yi', suffix)

from optparse import OptionParser
def parse_argv():
  parser = OptionParser(usage='<FILE LIST> | %prog [OPTIONS]', add_help_option=False)
  parser.add_option('-h', '--human-readable', action='store_true', dest='h',
                    default=False, help='Use human readable format')
  parser.add_option('', '--help', action='store_true', dest='help', default=False,
                    help='Show this help message')
  options, args = parser.parse_args()
  if options.help:
    parser.print_help()
    sys.exit()
  return parser, options

if __name__ == '__main__':
  main()
# __END___ }}}
