use books
db.createCollection("books")

db.books.insertMany( [
    { 
        isbn: 9780593087022, 
        title: "Ocean Prey (A Prey Novel)", 
        author: "John Sandford",  
        date: { year: 2021, month: 4 },
        pages: 432
    },

    { 
        isbn: 9780593465271, 
        title: "The Hill We Climb: An Inaugural Poem for the Country", 
        author: "Amanda Gorman",  
        date: { year: 2021, month: 3 },
        pages: 32
    },

    { 
        isbn: 9781982123741, 
        title: "The Devil's Hand", 
        author: "Jack Carr",  
        date: { year: 2021, month: 4 },
        pages: 544
    },

    { 
        isbn: 9781250178602, 
        title: "The Four Winds", 
        author: "Kristin Hannah",  
        date: { year: 2021, month: 2 },
        pages: 464
    },

    { 
        isbn: 9780525559474, 
        title: "The Midnight Library", 
        author: "Matt Haig",  
        date: { year: 2020, month: 9 },
        pages: 304
    },

    { 
        isbn: 9780765387561, 
        title: "The Invisible Life of Addie LaRue", 
        author: "V. E. Schwab",  
        date: { year: 2020, month: 10 },
        pages: 448 
    }]);

// list all books
db.books.find()

// list all book titles
db.books.find({}, { title: 1, _id: 0 })

// list all books written by X, where X is an author that you know is listed in your collection
db.books.find({author: 'Matt Haig'})

// list all books published in Y, where Y is a year
db.books.find( { "date.year": 2020 })

// list all books that have more than 100 pages but less than 500 pages
db.books.find(
    {
        $and: [
            { pages: { $lt: 500 }},
            { pages: { $gt: 100 }}
        ]
    }
)