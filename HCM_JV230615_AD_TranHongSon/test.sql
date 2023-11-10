DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS test;
USE test;
SET SQL_SAFE_UPDATES=OFF;

-- I. Thiết kế CSDL
-- YC1: Sử dụng câu lệnh để tạo database và các bảng có cấu trúc như sau: (30đ)

-- 1. Bảng teacher
create table teacher(
id int auto_increment primary key,
`name` varchar(100) not null unique,
`phone` varchar(50) not null unique,
`email` varchar(50) not null unique,
`birthday` date not null
);

-- 2. Bảng class_room
create table class_room(
id int auto_increment primary key,
`name` varchar(200) not null ,
`total_student` int default 0 ,
`start_date` date,
`end_date` date
);

alter table class_room
add constraint check_date check(end_date > start_date);

-- 3. Bảng teacher_class
create table teacher_class(
`teacher_id` int,
foreign key (teacher_id) references teacher(id),
`class_room_id` int,
foreign key (class_room_id) references class_room(id),
`start_date` date,
`end_date` date ,
`time_slot_start` int,
`time_slot_end` int
);

-- 4. Bảng student
create table student(
id int auto_increment primary key,
`name` varchar(150) not null,
`email` varchar(100) not null unique,
`phone` varchar(50) not null unique,
`gender` tinyint not null check(gender = 1 or gender = 2),
`class_room_id` int,
foreign key (class_room_id) references class_room(id),
`birthday` date not null
);

-- 5. Bảng subject
create table subject(
id int auto_increment primary key,
`name` varchar(200) not null unique
);

-- 6. Bảng mark
create table mark(
`student_id` int not null,
foreign key (student_id) references student(id),
`subject_id` int,
foreign key (subject_id) references subject(id),
`score` int not null check(score >=0 and score <= 10)
);

-- YC2: Sử dụng câu lệnh thêm dữ liệu vào các bảng như sau: (10đ).

-- 1. Bảng teacher ít nhất là 5 bản ghi dữ liệu phù hợp
insert into teacher(name, phone, email, birthday) values 
('Nguyễn Minh Khôi', '0909123456', 'khoi@gmail.com', '1997-12-12'),
('Nguyễn Khánh Linh', '0909123454', 'linh@gmail.com', '1993-12-22'),
('Trần Hồng Dương', '0909123452', 'duong@gmail.com', '1991-11-30'),
('Phạm Trần Sơn', '0909123322', 'son@gmail.com', '1990-12-12'),
('Đỗ Khánh Linh', '0909123434', 'linh2@gmail.com', '1999-01-01');

-- 2. Bảng class_room ít nhất là 5 bản ghi dữ liệu phù hợp
insert into class_room(name, start_date, end_date ) values 
('12A01', '2023-09-01', '2024-07-01'),
('12A02', '2023-09-01', '2024-07-01'),
('12A03', '2023-09-01', '2024-07-01'),
('12A04', '2023-09-01', '2024-07-01'),
('12A05', '2023-09-01', '2024-07-01');

-- 3. Bảng student Ít nhất 15 bản ghi dữ liệu phù hợp
insert into student(name, email, phone, gender, class_room_id, birthday) values 
('Nguyễn Minh Châu', 'chau@gmail.com', '0109123456', 1, 1, '2006-01-11'),
('Trần Hồng Sơn', 'sonno1@gmail.com', '0908250198', 2, 2, '2006-02-12'),
('Phạm Tuấn Hưng', 'hung@gmail.com', '0169123456', 2, 3, '2006-03-15'),
('Trần Thanh Ngân', 'ngan@gmail.com', '0379123456', 1, 1, '2006-04-18'),
('Nguyễn Đức Nam', 'nam@gmail.com', '0167912345', 2, 2, '2006-05-22'),
('Nguyễn Thanh Hoà', 'hoa@gmail.com', '0909124556', 2, 3, '2006-06-11'),
('Trần Công Phúc', 'phuc@gmail.com', '0989123456', 2, 1, '2006-07-03'),
('Phạm Đào Bích Huyền', 'huyen@gmail.com', '0921123456', 1, 2, '2006-09-04'),
('Lê Văn Lâm', 'lam@gmail.com', '0909123445', 2, 3, '2006-10-05'),
('Đào Trọng Tấn', 'tan@gmail.com', '0909123763', 2, 4, '2006-04-02'),
('Phạm Văn Chiêu', 'chieu@gmail.com', '0909123856', 2, 5, '2006-03-07'),
('Lê Lợi', 'loi@gmail.com', '0934823456', 2, 4, '2006-02-09'),
('Ngô Quyền', 'quyen@gmail.com', '0169163632', 2, 5, '2006-05-12'),
('Nguyễn Kiều', 'kieu@gmail.com', '0325123456', 1, 4, '2006-04-15'),
('Trần Văn Hai', 'hai@gmail.com', '0168123454', 1, 5, '2006-02-27');


-- 4. Bảng subject ít nhất 3 bản ghi dữ liệu phù hợp
insert into subject(name) values 
('Hoá Học'), ('Tin Học'), ('Toán Học'), ('Anh Văn'), ('Ngữ Văn');

-- 5. Bảng mark ít nhất 20 bản ghi dữ liệu phù hợp
insert into mark(student_id, subject_id , score) values 
(1, 1, 5), (2, 2, 6), (3, 3, 7), (4, 4, 8), 
(5, 5, 9), (6, 1, 10), (7, 2, 2), (8, 3, 3), 
(9, 4, 4), (10, 5, 5), (11, 1, 6), (12, 2, 7), 
(13, 3, 8), (14, 4, 9), (15, 5, 10), (1, 1, 1), 
(2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5);

-- 5. Tạo bản ghi cho teacher_class
insert into teacher_class(teacher_id, class_room_id) values 
(1, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 4);


-- II. Thực hiện các truy vấn dữ liệu.(60đ)
-- 1. Lấy ra danh sách Student có sắp xếp tăng dần theo Name gồm các cột sau: Id,
-- Name, Email, Phone, Gender, BirthDay, Age (5đ)
select id, name, email, phone,
case 
	when gender = 1 then 'female'
    else 'male'
end as gender,
birthday, year(now()) - year(birthday) as age
from student;

-- 2. Lấy ra danh sách Teacher gồm: Id, Name, Phone, Email, BirthDay, Age,
-- TotalCLass (5đ) <--
select t.*, year(now()) - year(t.birthday) as age, count(*) as total_class from teacher t join teacher_class tc on t.id = tc.teacher_id group by t.id;

-- 3. Truy vấn danh sách class_room gồm: Id, Name, TotalStudent, StartDate,
-- EndDate khai giảng năm 2023 (5đ)
select * from class_room where year(start_date) = '2023';

-- 4. Cập nhật cột ToalStudent trong bảng class_room = Tổng số Student của mỗi
-- class_room theo Id của class_room(5đ)
update class_room cr set cr.total_student = (select count(*) from student s where s.class_room_id = cr.id) ;

-- 5. Tạo View v_getStudentInfo thực hiện lấy ra danh sách Student gồm: Id, Name,
-- Email, Phone, Gender, BirthDay, ClassName, MarksAvg, Trong đó cột
-- MarksAvg hiển thị như sau:
-- 0 < MarksAvg <=5 Loại Yếu
-- 5 < MarksAvg < 7.5 Loại Trung bình
-- 7.5 <= MarksAvg <= 8 Loại GIỏi
-- 8 < MarksAvg Loại xuất sắc
-- (5đ)
create view v_getStudentInfo
as 
select s.id, s.name, s.email, s.phone,
case 
	when s.gender = 1 then 'female'
    else 'male'
end as gender, cr.name as classname, 
s.birthday, 
case 
	when avg(m.score) <= 5 then 'Loại Yếu'
	when avg(m.score) < 7.5 then 'Loại Trung bình'
	when avg(m.score) <= 8 then 'Loại GIỏi'
    else 'Loại xuất sắc' 
end as MarksAvg
from student s 
join class_room cr on s.class_room_id = cr.id
join mark m on s.id = m.student_id 
group by s.id
;

-- 6. View v_getStudentMax hiển thị danh sách Sinh viên có điểm trung bình >= 7.5
-- (5đ)
create view v_getStudentMax
as 
select s.name from student s join mark m on s.id = m.student_id group by s.id having avg(m.score) >= 7.5 ;

-- 7. Tạo thủ tục thêm mới dữ liệu vào bảng class_room (5đ)
delimiter //
create procedure addClassRoom(name_insert varchar(200), start_date_insert date, end_date_insert date) 
begin
	insert into class_room(name, start_date, end_date ) values 
(name_insert, start_date_insert, end_date_insert);
end //

-- 8. Tạo thủ tục cập nhật dữ liệu trên bảng student (5đ)
delimiter //
create procedure updateStudent(idUp int, nameUp varchar(150), emailUp varchar(100), phoneUp varchar(50), genderUp tinyint, class_room_idUp int, birthdayUp date) 
begin
	update student set name = nameUp where id = idUp;
	update student set email = emailUp where id = idUp;
	update student set phone = phoneUp where id = idUp;
	update student set gender = genderUp where id = idUp;
	update student set class_room_id = class_room_idUp where id = idUp;
	update student set birthday = birthdayUp where id = idUp;
end //

-- 9. Tạo thủ tục xóa dữ liệu theo id trên bảng subject (5đ)
delimiter //
create procedure deleteSubject(idDel int) 
begin
	delete from subject where id = idDel;
end //

-- 10.Tạo thủ tục getStudentPaginate lấy ra danh sách sinh viên có phân trang gồm:
-- Id, Name, Email, Phone, Gender, BirthDay, ClassName, Khi gọi thủ tuc
-- truyền vào limit và page (15đ)
delimiter //
create procedure getStudentPaginate(limitIn int, pageIn int)
begin
	declare offsetValue int;
    set offsetValue = (pageIn - 1) * limitIn;
    select s.id, s.name, s.phone, s.gender, s.birthday, cr.name from student s join class_room cr on s.class_room_id = cr.id limit limitIn offset offsetValue ;
end //

