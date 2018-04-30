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

library.add('order',
            book: library.books.last,
            reader: library.readers.last,
            date: Time.now.strftime('%d.%m.%y'))