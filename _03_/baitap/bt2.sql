create database quan_ly_don_hang;
use quan_ly_don_hang;
create table customer(
customer_id int primary key not null auto_increment,
customer_name varchar(30) not null,
customer_age int not null);

create table `order`(
order_id int primary key not null auto_increment,
customer_id int,
order_date datetime not null,
order_total_price int,
foreign key (customer_id) references customer(customer_id)
);

create table product(
product_id int primary key not null auto_increment,
product_name varchar(30) not null,
product_price int not null
);

create table order_detail(
product_id int,
order_id int,
order_quantity int not null,
primary key (product_id, order_id),
foreign key (product_id) references product(product_id),
foreign key (order_id) references `order`(order_id)
);


insert into customer (customer_name, customer_age)
value ('Minh Quan', 10);
insert into customer (customer_name, customer_age)
value ('Ngoc Oanh', 20);
insert into customer (customer_name, customer_age)
value ('Hong Ha', 50);

insert into `order` (customer_id, order_date)
value (1, '2006-03-21');
insert into `order` (customer_id, order_date)
value (2, '2006-03-23');
insert into `order` (customer_id, order_date)
value (1, '2006-03-16');

insert into product (product_name, product_price)
value ('May Giat', 3);
insert into product (product_name, product_price)
value ('Tu Lanh', 5);
insert into product (product_name, product_price)
value ('Dieu Hoa', 7);
insert into product (product_name, product_price)
value ('Quat', 1);
insert into product (product_name, product_price)
value ('Bep Dien', 2);

insert into order_detail (order_id, product_id, order_quantity)
value (1,1,3);
insert into order_detail (order_id, product_id, order_quantity)
value (1,3,7);
insert into order_detail (order_id, product_id, order_quantity)
value (1,4,2);
insert into order_detail (order_id, product_id, order_quantity)
value (2,1,1);
insert into order_detail (order_id, product_id, order_quantity)
value (3,1,8);
insert into order_detail (order_id, product_id, order_quantity)
value (2,5,4);
insert into order_detail (order_id, product_id, order_quantity)
value (2,3,3);

-- Hi???n th??? c??c th??ng tin  g???m oID, oDate, oPrice c???a t???t c??? c??c h??a ????n trong b???ng Order
use quan_ly_don_hang;
select `order`.order_id,`order`.order_date,`order`.order_total_price
from `order`;

-- Hi???n th??? danh s??ch c??c kh??ch h??ng ???? mua h??ng, v?? danh s??ch s???n ph???m ???????c mua b???i c??c kh??ch

 -- Hi???n th??? danh s??ch c??c kh??ch h??ng ???? mua h??ng
 select distinct customer.customer_name 
 from customer join `order`
 on customer.customer_id=`order`.customer_id;
 
select *
from customer
where customer.customer_id  in (select customer_id from `order`);
 
-- => y??u c??u ????? l??:
 select customer.customer_name,pro.product_name
 from customer join `order`
 on customer.customer_id=`order`.customer_id
 join  order_detail ord
 on `order`.order_id=ord.order_id
 join product pro
 on pro.product_id=ord.product_id;
 
--  Hi???n th??? t??n nh???ng kh??ch h??ng kh??ng mua b???t k??? m???t s???n ph???m n??o
select customer.customer_name 
from customer
where customer.customer_id not in 
(select customer.customer_id from customer  inner join `order`
on customer.customer_id=`order`.customer_id);

select * 
from customer c 
where not exists 
(select * from `order` o where o.customer_id = c.customer_id);

select * 
from customer
where customer.customer_id not in (select customer_id from `order`);
-- (dich nghia cau lenh 122:in ra t???t c??? c???t t??? b???ng kh??ch h??ng v???i ??k c???t id ?????y ko ( n???m trong id c???a order))


-- Hi???n th??? m?? h??a ????n, ng??y b??n v?? gi?? ti???n c???a t???ng h??a ????n (gi?? m???t h??a ????n ???????c t??nh b???ng t???ng gi?? b??n
--  c???a t???ng lo???i m???t h??ng xu???t hi???n trong h??a ????n. Gi?? b??n c???a t???ng lo???i ???????c t??nh = odQTY*pPrice)
select o.order_id, o.order_date, od.order_quantity * p.product_price as 'T???ng ti???n'
from `order` o inner join order_detail od
on o.order_id = od.order_id
inner join product p
on od.product_id = p.product_id;

