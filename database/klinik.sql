-- Database: klinik
-- Sesuai skema tugas: Pegawai & Pasien (gambar), plus Poli (pertemuan 6/7)
-- Cara pakai: mysql -u root -p < database/klinik.sql

CREATE DATABASE IF NOT EXISTS klinik
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE klinik;

-- Poli (pertemuan 6/7: hanya namaPoli di Flutter, id auto increment di DB)
CREATE TABLE IF NOT EXISTS poli (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_poli VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Pegawai (skema dari gambar tugas)
CREATE TABLE IF NOT EXISTS pegawai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nip VARCHAR(30) NOT NULL UNIQUE,
  nama VARCHAR(100) NOT NULL,
  tanggal_lahir VARCHAR(20) NOT NULL,
  nomor_telepon VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- Pasien (skema dari gambar tugas)
CREATE TABLE IF NOT EXISTS pasien (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nomor_rm VARCHAR(30) NOT NULL UNIQUE,
  nama VARCHAR(100) NOT NULL,
  tanggal_lahir VARCHAR(20) NOT NULL,
  nomor_telepon VARCHAR(20) NOT NULL,
  alamat TEXT NOT NULL
) ENGINE=InnoDB;

-- Dummy data (sama dengan yang hardcoded di Flutter saat ini)
INSERT INTO poli (nama_poli) VALUES
  ('Poli Anak'),
  ('Poli Kandungan'),
  ('Poli Gigi'),
  ('Poli THT')
ON DUPLICATE KEY UPDATE nama_poli = VALUES(nama_poli);

INSERT INTO pegawai (nip, nama, tanggal_lahir, nomor_telepon, email, password) VALUES
  ('197001011990031001', 'Budi Santoso', '1970-01-01', '081234567890', 'budi@klinik.com', 'budi123'),
  ('198505122010012002', 'Siti Aminah', '1985-05-12', '081298765432', 'siti@klinik.com', 'siti123'),
  ('199011232015031003', 'Andi Pratama', '1990-11-23', '081211223344', 'andi@klinik.com', 'andi123')
ON DUPLICATE KEY UPDATE nama = VALUES(nama);

INSERT INTO pasien (nomor_rm, nama, tanggal_lahir, nomor_telepon, alamat) VALUES
  ('RM-001', 'Joko Susilo', '1980-03-15', '081234567890', 'Jl. Merdeka No. 10, Jakarta'),
  ('RM-002', 'Dewi Lestari', '1992-07-22', '081298765432', 'Jl. Sudirman No. 25, Bandung'),
  ('RM-003', 'Rudi Hartono', '1975-11-08', '081211223344', 'Jl. Gatot Subroto No. 5, Semarang')
ON DUPLICATE KEY UPDATE nama = VALUES(nama);
