# Library #

## The Task ##

### Write program that determines ###
* Who often takes books
* What is the most popular book
* How many people ordered one of the three most popular books
* Save all Library data to file(s)
* Get all Library data from file(s)

#### Objects Attributes ####
* Book: title, author
* Order: book, reader, date, id
* Reader: name, email, city, street, house
* Author: name, biography
* Library: books, orders, readers, authors

#### Library Class Description ####
The Library class is dynamically created using the Constructor class. Class attributes based on class names located in app/classes folder. Class modules dynamically loaded into class from app/modules folder. You can extend the capabilities of the Library class just by simply adding the necessary files to the appropriate folders. Use files from app/classes/ and app/modules as pattern. You can add and delete into Library any objects, whose class was published into app/classes folder.

#### Module: Storage ####
This module is extend Library class functional to load and save data from data/ folder in root project dir. Keep in mind that working with .yml files is available from a data/ folder only.

.load('filename') - example for load data from exist YAML-file located into project data folder. Please note, .load method will be rewrite all data of Library, not merge or add.

.save method is smart method.
.save - in case when method was used without args it will save data into autonamed YAML file. If you have used .load('filename') before, .save will rewrite your filename.yml
.save('otherfile') - will save data to data/otherfile.yml

For more examples see run.rb in project root folder.