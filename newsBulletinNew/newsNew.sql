DROP DATABASE IF EXISTS `newsBulletinNew`;

CREATE DATABASE `newsBulletinNew`;
USE newsBulletinNew;


CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL ,
  `email` varchar(55) NOT NULL ,
  `mobileNo` BigInt(15) NOT NULL,
  `password` varchar(20) NOT NULL ,
  PRIMARY KEY (`id`)
) ;

insert into user (name,email,mobileNo,password) values ("rahul","rahul@gmail.com", 9661713931,"rahul");
insert into user (name,email,mobileNo,password) values ("amresh","amresh@gmail.com", 1234567890,"amresh");
insert into user (name,email,mobileNo,password) values ("rajesh","rajesh@gmail.com", 9661713931,"rajesh");
insert into user (name,email,mobileNo,password) values ("rajkishor","rajkishor@gmail.com", 1234567890,"rajkishor");

CREATE TABLE `news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(225) DEFAULT NULL,
  `content` MEDIUMTEXT DEFAULT NULL,
  `userId` int(11) unsigned NOT NULL,
  `updateDate` varchar(55) DEFAULT NULL,
  `view` int(11) unsigned DEFAULT 0,
  FOREIGN KEY (userId) REFERENCES `user`(`id`) ON DELETE CASCADE,
  PRIMARY KEY (`id`)
);
insert into news (title, content, userId, updateDate,view) values ("Tailored for exploring", "There are more than 750 million online .","1","2018-12-01",5);
insert into news (title, content, userId, updateDate,view) values ("Promoted Pins", "Pinterest has become one of the sports, fashion or travel.","2","2 dec 2018",8);
insert into news (title, content, userId, updateDate,view) values ("SAN FRANCISCO", "SAN FRANCISCO:  Pinterest late on  handle well.","3","2018 dec 03",2);
insert into news (title, content, userId, updateDate,view) values ("INVESTMENT", "Long-short hedge fund Valiant Google and Baidu.","4","2018-12-04",6);
insert into news (title, content, userId, updateDate) values ("SOCIAL NETWORK", "The group includes n valuation in 2011.","4","5/12/2018");


CREATE TABLE `likedUnliked`(
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`nId` int(11) unsigned NOT NULL,
`uId` int(11) unsigned NOT NULL ,
`result` int DEFAULT 0,
PRIMARY KEY(`id`),
FOREIGN KEY (uId) REFERENCES `user`(`id`) ON DELETE CASCADE,
FOREIGN KEY (nId) REFERENCES `news`(`id`) ON DELETE CASCADE
);

insert into `likedUnliked` (nId, uId, result) values (1,1,1);
insert into `likedUnliked` (nId, uId, result) values (3,1,1);
insert into `likedUnliked` (nId, uId, result) values (1,2,-1);
insert into `likedUnliked` (nId, uId, result) values (2,2,1);
insert into `likedUnliked` (nId, uId, result) values (3,2,-1);



CREATE TABLE `comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nId` int(11) unsigned NOT NULL,
  `pCommentId` int(11) unsigned DEFAULT NULL,
  `pUserId`  int(11) DEFAULT NULL,
  `uId` int(11) unsigned NOT NULL,
  `comment` MEDIUMTEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (nId) REFERENCES `news`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (uId) REFERENCES `user`(`id`) ON DELETE CASCADE
  
);

insert into comments (nId, uId, comment) values ("1", "1","i like it.");
insert into comments (nId,uId,  comment) values ("1", "2","nice!!");
insert into comments (nId,uId, comment) values ("1", "3","good news!!");
insert into comments (nId,pCommentId, pUserId, uId, comment) values ("1","1","1", "2","it is fake.");
insert into comments (nId,pCommentId, pUserId, uId, comment) values ("1","1","2", "1","its okk.");
insert into comments (nId,pCommentId, pUserId, uId, comment) values ("1","2","2", "3","hiii");
insert into comments (nId,pCommentId, pUserId, uId, comment) values ("1","2","3", "4","hello");
/*
CREATE TABLE `viewedContent`(
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`nId` int(11) unsigned NOT NULL ,
`uId` int(11) unsigned NOT NULL ,
PRIMARY KEY(`id`),
FOREIGN KEY (uId) REFERENCES `user`(`id`) ON DELETE CASCADE,
FOREIGN KEY (nId) REFERENCES `news`(`id`) ON DELETE CASCADE
);

insert into `viewedContent` (nId, uId) values (1,1);
insert into `viewedContent` (nId, uId) values (3,2);
insert into `viewedContent` (nId, uId) values (5,2);

*/

/*
CREATE TABLE `likedContent`(
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`nId` int(11) unsigned NOT NULL,
`uId` int(11) unsigned NOT NULL ,
PRIMARY KEY(`id`),
FOREIGN KEY (uId) REFERENCES `user`(`id`) ON DELETE CASCADE,
FOREIGN KEY (nId) REFERENCES `news`(`id`) ON DELETE CASCADE
);

insert into `likedContent` (nId, uId) values (1,1);
insert into `likedContent` (nId, uId) values (3,1);
insert into `likedContent` (nId, uId) values (1,2);
insert into `likedContent` (nId, uId) values (2,2);
insert into `likedContent` (nId, uId) values (3,2);

CREATE TABLE `unLikedContent`(
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`nId` int(11) unsigned NOT NULL,
`uId` int(11) unsigned NOT NULL ,
PRIMARY KEY(`id`),
FOREIGN KEY (uId) REFERENCES `user`(`id`) ON DELETE CASCADE,
FOREIGN KEY (nId) REFERENCES `news`(`id`) ON DELETE CASCADE
);

insert into `unLikedContent` (nId, uId) values (2,1);
insert into `unLikedContent` (nId, uId) values (4,1);
insert into `unLikedContent` (nId, uId) values (4,2);
*/

/*
CREATE TABLE `comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nId` int(11) unsigned NOT NULL,
  `uName` varchar(55) NOT NULL,
  `comment` MEDIUMTEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (nId) REFERENCES `news`(`id`) ON DELETE CASCADE
  FOREIGN KEY (uName) REFERENCES `user`(`name`) ON DELETE CASCADE
);

insert into comments (nId, uName, comment) values ("1", "rahul","i like it.");
insert into comments (nId, uName, comment) values ("1", "amresh","it is fake.");
insert into comments (nId, uName, comment) values ("1", "rahul","its okk.");
insert into comments (nId, uName, comment) values ("2", "amresh","nice!!");
*/


/*
CREATE TABLE `reply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nId` int(11) unsigned NOT NULL,
  `cId`  MEDIUMTEXT DEFAULT NULL,
  `uName` varchar(55) NOT NULL,
  `comment` MEDIUMTEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (nId) REFERENCES `news`(`id`) ON DELETE CASCADE
  
);

insert into comments (nId, cId, uName, comment) values ("1",null, "rahul","i like it.");
insert into comments (nId, cId, uName, comment) values ("1","i like it", "amresh","it is fake.");
insert into comments (nId, cId, uName, comment) values ("1","it is fake", "rahul","its okk.");
insert into comments (nId, cId, uName, comment) values ("2",null, "amresh","nice!!");
*/

/*DELETE viewedContent;*/






/*
DROP table Table1_sal;

DROP table Table1;
create table `Table1`
(
  `id` varchar(2),
  `name` varchar(2),
  PRIMARY KEY (id)
);


DROP table Table1Addr;
create table `Table1Addr`
(
  `addid` varchar(2),
  `Address` varchar(2),
  PRIMARY KEY (addid)
);

Create table `Table1_sal`
(
  `salid` varchar(2),
  `addId` varchar(2),
  `Id` varchar(2),
  PRIMARY KEY (salid),
  index(addId),
  index(Id),
  FOREIGN KEY (addId) REFERENCES `Table1Addr`(`addid`),
  FOREIGN KEY (id) REFERENCES `Table1`(`id`)
);
*/

/*
select news.*, user.name from news inner join user on news.userId=user.id;

 select news.id,news.title,news.content,news.updateDate,news.view, user.name from news inner join user on news.userId=user.id;


//query for getting a like and dislike in a singal table;


 select t2.id, t2.liked as liked, t3.unliked as unliked from  (select news.id, t1.liked as liked from news left join (select nId, count(result) as liked from likedUnliked where result=1 group by nId) as t1 on news.id=t1.nId) as  t2 left join (select nId, count(result) as unliked from likedUnliked where result=-1 group by nId) as t3 on t2.id=t3.nId order by id;


mysql> select t4.*, t5.liked as liked, t5.unliked as unliked from (select news.id,news.title,news.content,news.updateDate,news.view, user.name from news inner join user on news.userId=user.id) as t4 left join ( select t2.id, t2.liked as liked, t3.unliked as unliked from  (select news.id, t1.liked as liked from news left join (select nId, count(result) as liked from likedUnliked where result=1 group by nId) as t1 on news.id=t1.nId) as  t2 left join (select nId, count(result) as unliked from likedUnliked where result=-1 group by nId) as t3 on t2.id=t3.nId) as t5 on t5.id=t4.id;

 select t6.*, count(nId) as noOfComment from ( select t4.*, t5.liked as liked, t5.unliked as unliked from (select news.id,news.title,news.content,news.updateDate,news.view, user.name from news inner join user on news.userId=user.id) as t4 left join ( select t2.id, t2.liked as liked, t3.unliked as unliked from  (select news.id, t1.liked as liked from news left join (select nId, count(result) as liked from likedUnliked where result=1 group by nId) as t1 on news.id=t1.nId) as  t2 left join (select nId, count(result) as unliked from likedUnliked where result=-1 group by nId) as t3 on t2.id=t3.nId) as t5 on t5.id=t4.id) as t6 left join comments on t6.id=comments.nId group by id;

///
select t2.id, t2.nId,t2.pCommentId,t2.comment,t2.pUserName, user.name as userName from ( select comments.* , user.name as pUserName from comments left join user on comments.pUserId=user.id order by id) as t2 left join user on t2.uId=user.id where t2.nId=6  order by id;

//new query

select comments.*, user.name from comments, user where nId=1 and user.id=comments.uId order by id;

 select comments.id, comments.nId, comments.pCommentId, comments.comment, (select user.name  from user where comments.pUserId=user.id) as pUserName, user.name as userName from comments, user where nId=1 and comments.uId=user.id order by id;

select comments.*, user1.name as userName, user2.name as pUserName from comments left join user as user1 on (comments.uId=user1.id) left join user as user2 on (comments.pUserId=user2.id) where comments.nId=1 order by id;

select news.*, user.name , unlikeTable.unliked as unliked, likeTable.liked as liked from news left join user on (news.userId=user.id) left join ( select nId, count(result) as unliked from likedUnliked where result=-1 group by nId) as unlikeTable on (news.id=unlikeTable.nId) left join ( select nId, count(result) as liked from likedUnliked where result=1 group by nId) as likeTable on (news.id=likeTable.nId);

//
 select news.*, user.name , unlikeTable.unliked as unliked, likeTable.liked as liked, commentCount.noofcomments as noOfComment from news left join user on (news.userId=user.id) left join ( select nId, count(result) as unliked from likedUnliked where result=-1 group by nId) as unlikeTable on (news.id=unlikeTable.nId) left join ( select nId, count(result) as liked from likedUnliked where result=1 group by nId) as likeTable on (news.id=likeTable.nId) left join ( select news.id , count(nId) as noofcomments from news left join comments on (news.id=comments.nId) group by id) as commentCount on (news.id=commentCount.id)  order by news.id;







//chandramati

mysql> select * from news left join comments on (news.id=comments.nId) join user on (comments.uId=user.id) where news.id="1";


//query given by rk
select t1.nId,t1.liked as liked,t2.nId,t2.unliked as unliked from (select nId,count(result) as liked from likedUnliked where result=1 group by nId) as t1,   (select nId, count(result) as unliked from likedUnliked where result=-1 group by nId) as t2 where t2.nId = t1.nId;













*/






























