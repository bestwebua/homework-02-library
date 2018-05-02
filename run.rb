require_relative 'app/library'

library = Library.new

library.add('author',
            name: 'Paolo Perrotta',
            biography: 'Awesome Paolo Perrotta bio...')
library.add('book',
            title: 'Metaprogramming Ruby',
            author: library.authors.last)
library.add('reader',
            name: 'John Doe',
            email: 'john_doe@domain.com',
            city: 'City',
            street: 'Street',
            house: '42')
library.add('reader',
            name: 'Jane Doe',
            email: 'jane_doe@domain.com',
            city: 'City',
            street: 'Street',
            house: '42')
library.add('order',
            book: library.books.last,
            reader: library.readers.last,
            date: Time.now.strftime('%d.%m.%y'))

library.delete('reader', name: 'Jane Doe')
library.delete('order', id: '00001')

library.top_reader
library.top_book
library.count_readers_of_bestsellers_top3

library.load('test')          # will load test.yml from data folder 
library.save                  # if load from somefile.yml will rewrite this file, else will create autonamed file
library.save('filename')      # with argumens save to the filename.yml