use Booksstore

select * from Customers
select * from Books
select * from Orders

--Retrive all the books in the "fiction" genre

select * from Books where Genre='Non-Fiction';

--Find books published after the year "1950"

select * from Books where Published_Year>1950;

--List all customers from "canada"

select name,Country from Customers where Country='Canada';

--Show orders placed in "november 2023"

select * from Orders where MONTH(Order_Date) =11 and YEAR(Order_Date)=2023;

--Retrive the total stocks of books available

select  SUM(stock) as total_books from Books;

--Find the details of the most expensive book

select Top 1 * from Books order by price desc ;

--Show all customers those order more than 1 quantity of a book

select * from Orders where quantity>1;

--Retrive all order where total amount exceeds $20

select * from Orders where Total_Amount>20;

--List all the genres available in the book table

select distinct Genre from Books ;

--Find the book with the lowest stock

select top 1 * from Books order by Stock;

--Calculate the total revenue generated from all orders

select sum(total_amount) as total_revenue from Orders;


----level changed

--retrive the total number of books sold for each genre

select b.Genre,SUM(o.Quantity) as total_books from Orders o join Books b on o.Book_ID=b.Book_ID  group by b.genre;

--Find the average price of books in the fantasy genre

SELECT AVG(price) AS average_fantasy_book_price
FROM books
WHERE genre = 'Fantasy';

--List customers who have placed at least 2 orders

SELECT 
    c.customer_id, 
    c.name,
    COUNT(o.order_id) AS total_orders 
FROM Customers c 
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.name
HAVING COUNT(o.order_id) >= 2;

--Find the most frequently ordered book

select Top 1 o.Book_ID ,b.title as book ,count(o.Order_ID) as orders  from orders o join Books b  on  o.book_id=b.book_id
group by o.Book_ID,b.title
order by orders desc;


--Show the top 3 most expensive books of "Fantasy" genre

select * from books
select * from Orders

SELECT TOP 3 
    Book_ID,
    Title,
    Genre,Price
FROM Books  
WHERE Genre = 'Fantasy'
ORDER BY Price DESC;

--Retrive the total quantity of book sold by each author

select b.Author,SUM(o.Quantity) as total_quantity from books b join Orders o 
on b.Book_ID=o.Book_ID
group by b.Author;

--List the cities where customers who never spents over $30 are located

select distinct c.City,o.Total_Amount  from Customers c join Orders o on c.Customer_ID=o.Customer_ID
where Total_Amount>30
order by Total_Amount

--Find the customer who spent the most on orders

select Top 1 c.customer_id, c.name, sum(o.total_amount) as total from Customers c join Orders o on c.Customer_ID=o.Customer_ID
group by c.Customer_ID,c.Name
order by total desc

--Calculate the stocks remaining after fulfilling all orders

SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.quantity), 0) AS order_quantity,
    b.Stock - COALESCE(SUM(o.quantity), 0) AS remaining_stock
FROM Books b 
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
ORDER BY b.Book_ID DESC;
