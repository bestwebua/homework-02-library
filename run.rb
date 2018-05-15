require_relative 'app/library'

library = Library.new

library.add('author', name: 'Paolo Perrotta', biography: 'Awesome Paolo Perrotta bio...')
library.add('book', title: 'Metaprogramming Ruby', author: library.authors.last)
library.add('reader', name: 'John Doe', email: 'john_doe@domain.com', city: 'City', street: 'Street', house: '42')
library.add('reader', name: 'Jane Doe', email: 'jane_doe@domain.com', city: 'City', street: 'Street', house: '42')
library.add('order', book: library.books.last, reader: library.readers.last, date: Time.now.strftime('%d.%m.%y'))

library.delete('reader', name: 'Jane Doe')
library.delete('order', id: '00001')

library.top_reader
library.top_book
library.count_readers_of_bestsellers_top3

# it will rewrite all current Library data
library.load('test')

library.add('author', name: 'Rod Duncan', biography: 'Awesome Rod Duncan bio...')
library.add('book', title: 'The Mentalist', author: library.authors.last)
library.add('reader', name: 'Patrick Jane', email: 'patrick_jane@domain.com', city: 'Sacramento', street: 'Street', house: '42')
library.add('order', book: library.books.last, reader: library.readers.last, date: Time.now.strftime('%d.%m.%y'))

# Types of target are case insensitive, possible to create object like in case below:
# library.add('Author', name: 'Rod Duncan', biography: 'Awesome Rod Duncan bio...')
# library.add('AUTHOR', name: 'Rod Duncan', biography: 'Awesome Rod Duncan bio...')

# .save - in case when method was used without args it will save data into autonamed YAML file.
# If you have used .load('filename') before, .save will rewrite your filename.yml
library.save

# .save('otherfile') - will save data to data/otherfile.yml
