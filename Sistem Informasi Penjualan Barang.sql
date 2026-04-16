CREATE DATABASE TokoDB;
go

use TokoDB;
go

CREATE TABLE Barang (
    id_barang INT PRIMARY KEY IDENTITY,
    nama_barang VARCHAR(100),
    harga_beli INT,
    harga_jual INT,
    margin AS (harga_jual - harga_beli)  -- derived (computed column)
);

CREATE TABLE Pelanggan (
    id_pelanggan INT PRIMARY KEY IDENTITY,
    nama VARCHAR(100),
    jalan VARCHAR(100),
    kota VARCHAR(50),
    kode_pos VARCHAR(10)
);

CREATE TABLE No_Telp (
    id INT PRIMARY KEY IDENTITY,
    id_pelanggan INT,
    no_telp VARCHAR(15),
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan)
);

CREATE TABLE Faktur (
    id_faktur INT PRIMARY KEY IDENTITY,
    id_pelanggan INT,
    tanggal_pesan DATE,
    tanggal_kirim DATE,
    lama_proses AS (DATEDIFF(DAY, tanggal_pesan, tanggal_kirim)),
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan)
);

CREATE TABLE Detail_Faktur (
    id_detail INT PRIMARY KEY IDENTITY,
    id_faktur INT,
    id_barang INT,
    jumlah INT,
    subtotal AS (jumlah * (
        SELECT harga_jual FROM Barang WHERE Barang.id_barang = Detail_Faktur.id_barang
    )),
    FOREIGN KEY (id_faktur) REFERENCES Faktur(id_faktur),
    FOREIGN KEY (id_barang) REFERENCES Barang(id_barang)
);

USE TokoDB;

INSERT INTO Barang (nama_barang, harga_beli, harga_jual)
VALUES 
('Laptop', 5000000, 6500000),
('Mouse', 50000, 80000);

INSERT INTO Pelanggan (nama, jalan, kota, kode_pos)
VALUES 
('Andi', 'Jl. Merdeka', 'Denpasar', '80200');

INSERT INTO No_Telp (id_pelanggan, no_telp)
VALUES 
(1, '08123456789'),
(1, '08987654321');

INSERT INTO Faktur (id_pelanggan, tanggal_pesan, tanggal_kirim)
VALUES 
(1, '2026-04-10', '2026-04-12');

SELECT * FROM Barang;
SELECT * FROM Pelanggan;
SELECT * FROM Faktur;
SELECT * FROM Detail_Faktur;
