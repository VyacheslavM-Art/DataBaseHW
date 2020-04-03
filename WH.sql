use vk;
SET SQL_SAFE_UPDATES = 0;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

update vk.users 
set created_at = now() where created_at is null;
update vk.users
set updated_at =now() where updated_at is null;

-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время
-- помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

alter table vk.users
 modify column created_at datetime null;

 alter table vk.users
 modify column updated_at datetime null;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким 
-- образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей

select * from storehouses_products order by case `value` when `value` > 0 then `value` end, `value` asc;

-- Подсчитайте средний возраст пользователей в таблице user
select avg(
(year(current_date)-year(birthday))-
(date_format(current_date,'%m%d')<date_format(birthday, '%m%d'))
 ) as AVG_age
 from users
 
