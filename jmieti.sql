-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2023 at 11:42 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jmieti`
--

-- --------------------------------------------------------

--
-- Table structure for table `class_list`
--

CREATE TABLE `class_list` (
  `class_id` int(5) NOT NULL,
  `class_name` varchar(256) NOT NULL,
  `class_teacher_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_list`
--

INSERT INTO `class_list` (`class_id`, `class_name`, `class_teacher_id`) VALUES
(1, 'B.Tech CSE 2023', 2),
(2, 'B.tech AI 2019-2023', 4);

-- --------------------------------------------------------

--
-- Table structure for table `notes_list`
--

CREATE TABLE `notes_list` (
  `note_id` int(10) NOT NULL,
  `subject_id` int(10) NOT NULL,
  `note_title` varchar(256) NOT NULL,
  `note_ext` varchar(256) NOT NULL,
  `note_url` varchar(1025) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes_list`
--

INSERT INTO `notes_list` (`note_id`, `subject_id`, `note_title`, `note_ext`, `note_url`) VALUES
(1, 1, 'Tentative-Engg.pdf', '.pdf', 'https://firebasestorage.googleapis.com/v0/b/evidyalaya-23ff7.appspot.com/o/notes?alt=media&token=aba0a5f9-4a7e-46cd-a7b5-fb6c9c9d24bb'),
(2, 1, 'VID-20230414-WA0000.mp4', '.mp4', 'https://firebasestorage.googleapis.com/v0/b/evidyalaya-23ff7.appspot.com/o/notes?alt=media&token=d31ea58f-d2eb-4635-8ff2-08cb71940de3'),
(3, 1, 'Tenor mobile default Ringtone.mp3', '.mp3', 'https://firebasestorage.googleapis.com/v0/b/evidyalaya-23ff7.appspot.com/o/notes?alt=media&token=30bb23bc-ac7f-434f-9a71-519e654da400'),
(4, 2, 'Tenor mobile default Ringtone.mp3', '.mp3', 'https://firebasestorage.googleapis.com/v0/b/evidyalaya-23ff7.appspot.com/o/notes?alt=media&token=531c19ed-c96d-46ca-bf02-28af4f984ace'),
(5, 2, 'April Attendance .pdf', '.pdf', 'https://firebasestorage.googleapis.com/v0/b/evidyalaya-23ff7.appspot.com/o/notes?alt=media&token=b27796f6-acdb-40aa-b1ae-37d57863f294');

-- --------------------------------------------------------

--
-- Table structure for table `subject_list`
--

CREATE TABLE `subject_list` (
  `subject_id` int(10) NOT NULL,
  `subject_name` varchar(256) NOT NULL,
  `class_id` int(10) NOT NULL,
  `subject_teacher_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject_list`
--

INSERT INTO `subject_list` (`subject_id`, `subject_name`, `class_id`, `subject_teacher_id`) VALUES
(1, 'Cyber Security', 1, 2),
(2, 'WIT', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(9) NOT NULL,
  `name` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `designation` varchar(256) NOT NULL,
  `profile_picture` varchar(256) NOT NULL,
  `current_class` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `username`, `designation`, `profile_picture`, `current_class`) VALUES
(1, 'Director', 'riteshsaini331@gmail.com', '8708272170', 'eda43fa265dd3956382d9563e9c5194f942afadece8391aa9d70f5045dd04f4a', 'director@jmieti.evidyalaya.in', 'Director', 'https://images.unsplash.com/photo-1533794299596-8e62c88ff975?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 0),
(2, 'Teacher 1', 'rkstuvwxyz@gmail.com', '8708272170', '7930886779995909d619175c6869e3d013a05c9c6352656c44e3a88cf900ae42', 'teacher1003@jmieti.evidyalaya.in', 'Teacher', 'https://2.bp.blogspot.com/-BVgTOe82aaI/VZln4Ny-LPI/AAAAAAAAA6Y/hKchnruxKtg/s1600/2000px-User_icon_2.svg.png', 0),
(3, 'Ritesh ', 'rkstuvwxyz@gmail.com', '8708272170', '66088e2e908cb5c5d1ec9c95d01489e0e762d7a751203ba8e418d094cbcad264', 'ritesh8519147@jmieti.evidyalaya.in', 'Student', 'https://2.bp.blogspot.com/-BVgTOe82aaI/VZln4Ny-LPI/AAAAAAAAA6Y/hKchnruxKtg/s1600/2000px-User_icon_2.svg.png', 1),
(4, 'Teacher 2', 'rkstuvwxyz@gmail.com', '8708272170', '7930886779995909d619175c6869e3d013a05c9c6352656c44e3a88cf900ae42', 'Teacher1004@jmieti.evidyalaya.in', 'Teacher', 'https://2.bp.blogspot.com/-BVgTOe82aaI/VZln4Ny-LPI/AAAAAAAAA6Y/hKchnruxKtg/s1600/2000px-User_icon_2.svg.png', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class_list`
--
ALTER TABLE `class_list`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `class_teacher` (`class_teacher_id`);

--
-- Indexes for table `notes_list`
--
ALTER TABLE `notes_list`
  ADD PRIMARY KEY (`note_id`);

--
-- Indexes for table `subject_list`
--
ALTER TABLE `subject_list`
  ADD PRIMARY KEY (`subject_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `teacher_id` (`subject_teacher_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class_list`
--
ALTER TABLE `class_list`
  MODIFY `class_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notes_list`
--
ALTER TABLE `notes_list`
  MODIFY `note_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subject_list`
--
ALTER TABLE `subject_list`
  MODIFY `subject_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class_list`
--
ALTER TABLE `class_list`
  ADD CONSTRAINT `class_teacher` FOREIGN KEY (`class_teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subject_list`
--
ALTER TABLE `subject_list`
  ADD CONSTRAINT `class_id` FOREIGN KEY (`class_id`) REFERENCES `class_list` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_id` FOREIGN KEY (`subject_teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
