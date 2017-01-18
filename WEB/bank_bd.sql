-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Янв 18 2017 г., 12:27
-- Версия сервера: 5.5.53-0+deb8u1
-- Версия PHP: 5.6.29-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `bank_bd`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
`id` int(11) NOT NULL COMMENT 'id аккаунта',
  `email` varchar(64) NOT NULL COMMENT 'email пользователя',
  `username` varchar(64) NOT NULL COMMENT 'Логин пользователя',
  `password` varchar(64) NOT NULL COMMENT 'Пароль пользователя',
  `first_name` varchar(255) NOT NULL COMMENT 'Имя',
  `last_name` varchar(255) NOT NULL COMMENT 'Фамилия',
  `middle_name` varchar(255) NOT NULL COMMENT 'Отчество',
  `gid` int(11) NOT NULL COMMENT 'id группы'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `username`, `password`, `first_name`, `last_name`, `middle_name`, `gid`) VALUES
(1, 'admin@admin.com', 'bank_user', '3e0d132f160944340a18c4e449ea86e2', '', '', '', 1),
(2, 'mrB4el@mail.ru', 'mrB4el', 'e10adc3949ba59abbe56e057f20f883e', 'Oleg', 'Lobanov', 'Vladimirovich', 3),
(3, 'test@test.ru', 'test', 'd41d8cd98f00b204e9800998ecf8427e', 'xzczxc', 'asdad', 'xczxczx', 1),
(5, 'marina@mail.com', 'marina', 'ce5225d01c39d2567bc229501d9e610d', 'marina', 'meyta', 'valeryevna', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `credits`
--

CREATE TABLE IF NOT EXISTS `credits` (
`id` int(11) NOT NULL COMMENT 'id кредита',
  `uid` int(11) NOT NULL COMMENT 'id пользователя',
  `quantity` int(11) NOT NULL COMMENT 'сумма запроса',
  `percents` int(11) NOT NULL COMMENT 'годовой процент',
  `date` date NOT NULL COMMENT 'дата выдачи',
  `status` int(11) NOT NULL COMMENT 'статус кредита (0-3)',
  `mid` int(11) NOT NULL COMMENT 'id выдавшего',
  `signature` varchar(32) NOT NULL COMMENT 'подпись выдавшего'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `credits`
--

INSERT INTO `credits` (`id`, `uid`, `quantity`, `percents`, `date`, `status`, `mid`, `signature`) VALUES
(1, 2, 1000000, 12, '2016-01-02', 2, 5, 'e4da3b7fbbce2345d7772b0674a318d5');

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
`id` int(11) NOT NULL COMMENT 'id группы',
  `groupname` varchar(11) NOT NULL COMMENT 'имя группы',
  `allow_requests` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'разрешение.запрос',
  `allow_submits` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'разрешение.подтверждение',
  `allow_edits` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'разрешение.редактирование'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `groups`
--

INSERT INTO `groups` (`id`, `groupname`, `allow_requests`, `allow_submits`, `allow_edits`) VALUES
(1, 'Клиенты', 1, 0, 0),
(2, 'Менеджер', 0, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
`id` int(11) NOT NULL COMMENT 'id платежа',
  `uid` int(11) NOT NULL COMMENT 'id аккаунта',
  `date` date NOT NULL COMMENT 'дата платежа',
  `payment` int(11) NOT NULL COMMENT 'размер платежа',
  `secret` text NOT NULL COMMENT 'Секрет для подтверждения',
  `confirmed` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'подтверждён или нет'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payments`
--

INSERT INTO `payments` (`id`, `uid`, `date`, `payment`, `secret`, `confirmed`) VALUES
(1, 2, '0000-00-00', 2212, '1212', 0),
(2, 2, '0000-00-00', 456489, '78978', 0),
(3, 2, '0000-00-00', 7897, 'sadasd', 0),
(4, 2, '2017-01-28', 5000, '25555', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `requests`
--

CREATE TABLE IF NOT EXISTS `requests` (
`id` int(11) NOT NULL COMMENT 'id запроса',
  `uid` int(11) NOT NULL COMMENT 'id пользователя',
  `quantity` int(11) NOT NULL COMMENT 'сумма запроса',
  `percents` int(11) NOT NULL COMMENT 'годовой процент',
  `days` int(11) NOT NULL COMMENT 'срок (в днях)',
  `phone` varchar(20) NOT NULL COMMENT 'Телефон клиента'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `requests`
--

INSERT INTO `requests` (`id`, `uid`, `quantity`, `percents`, `days`, `phone`) VALUES
(1, 2, 1212, 22, 13, 'wq'),
(2, 2, 222, 123, 123, '123');

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
`id` int(11) NOT NULL COMMENT 'id сессии',
  `uid` int(11) DEFAULT NULL COMMENT 'id пользовтаеля',
  `session` varchar(64) DEFAULT NULL COMMENT 'сессия',
  `ip` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `sessions`
--

INSERT INTO `sessions` (`id`, `uid`, `session`, `ip`) VALUES
(1, 0, '2', '192.168.1.1'),
(2, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(3, 2, 'd41d8cd98f00b204e9800998ecf8427e', '192.168.1.1'),
(4, 2, 'c81e728d9d4c2f636f067f89cc14862c', '192.168.1.1'),
(5, 5, 'ce5225d01c39d2567bc229501d9e610d', '192.168.1.1'),
(6, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(7, 2, '918a6c81f45249b91743ca8bfebd29af', '192.168.1.1'),
(8, 2, '918a6c81f45249b91743ca8bfebd29af', '192.168.1.1'),
(9, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(10, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(11, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(12, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(13, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(14, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(15, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(16, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(17, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(18, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(19, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(20, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(21, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(22, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(23, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(24, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(25, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(26, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(27, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(28, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(29, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(30, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(31, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(32, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1'),
(33, 2, 'a71326da68e5ea85df3bfeec7fc1e686', '192.168.1.1');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `username` (`username`), ADD UNIQUE KEY `email` (`email`);

--
-- Индексы таблицы `credits`
--
ALTER TABLE `credits`
 ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `groups`
--
ALTER TABLE `groups`
 ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `payments`
--
ALTER TABLE `payments`
 ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `requests`
--
ALTER TABLE `requests`
 ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sessions`
--
ALTER TABLE `sessions`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id аккаунта',AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `credits`
--
ALTER TABLE `credits`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id кредита',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `groups`
--
ALTER TABLE `groups`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id группы',AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `payments`
--
ALTER TABLE `payments`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id платежа',AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `requests`
--
ALTER TABLE `requests`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id запроса',AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `sessions`
--
ALTER TABLE `sessions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id сессии',AUTO_INCREMENT=34;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
