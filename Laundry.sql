CREATE TABLE CUSTOMER 
(id_customer NUMBER (11), 
nama_customer VARCHAR2 (30),
telp_customer VARCHAR2 (15), 
PRIMARY KEY(id_customer));

CREATE TABLE PEGAWAI 
(id_pegawai NUMBER (11), 
telp_pegawai VARCHAR2 (15),
nama_pegawai VARCHAR2 (30), 
PRIMARY KEY(id_pegawai));

CREATE TABLE LAUNDRY(
id_laundry NUMBER(11),
id_pegawai NUMBER (11),
id_customer NUMBER (11),
berat NUMBER(10),
jml_item NUMBER(10),
PRIMARY KEY (id_laundry));

ALTER TABLE LAUNDRY ADD FOREIGN KEY (id_customer ) REFERENCES CUSTOMER (id_customer);

ALTER TABLE LAUNDRY ADD FOREIGN KEY (id_pegawai ) REFERENCES PEGAWAI (id_pegawai);

CREATE TABLE DETAIL_LAUNDRY(
id_laundry NUMBER(11),
nama_item VARCHAR2 (30),
kode_item NUMBER(10),
harga NUMBER(10),
tgl_selesai DATE,
tgl_terima DATE,
PRIMARY KEY (id_laundry));

ALTER TABLE DETAIL_LAUNDRY ADD FOREIGN KEY (id_laundry ) REFERENCES LAUNDRY (id_laundry);

CREATE TABLE PEMBAYARAN(
id_pembayaran NUMBER(11),
id_laundry NUMBER(11),
total_harga NUMBER(10),
PRIMARY KEY (id_pembayaran));

ALTER TABLE PEMBAYARAN ADD FOREIGN KEY (id_laundry ) REFERENCES DETAIL_LAUNDRY (id_laundry);

INSERT INTO CUSTOMER VALUES (1, 'RANGGA', '08132423544');
INSERT INTO CUSTOMER VALUES (2, 'HARRY', '08932426444');
INSERT INTO CUSTOMER VALUES (3, 'EMMA', '08532423044');
INSERT INTO CUSTOMER VALUES (4, 'NADYA', '08732423444');
INSERT INTO CUSTOMER VALUES (5, 'SINTA', '08532424444');

INSERT ALL 
    INTO PEGAWAI ( id_pegawai, telp_pegawai, nama_pegawai ) VALUES ( 1, '08123456781', 'HENDRA' )
    INTO PEGAWAI ( id_pegawai, telp_pegawai, nama_pegawai ) VALUES ( 2, '08512345678', 'NANA' )
    INTO PEGAWAI ( id_pegawai, telp_pegawai, nama_pegawai ) VALUES ( 3, '08712345632', 'ALIF' )
    INTO PEGAWAI ( id_pegawai, telp_pegawai, nama_pegawai ) VALUES ( 4, '08954321567', 'ADITYA' )
    INTO PEGAWAI ( id_pegawai, telp_pegawai, nama_pegawai ) VALUES ( 5, '08634567321', 'FANIA')  
SELECT * FROM dual;

INSERT ALL 
    INTO LAUNDRY ( id_laundry, id_pegawai, id_customer, berat, jml_item ) VALUES ( 100, 1, 1, 7, 9 )  
    INTO LAUNDRY ( id_laundry, id_pegawai, id_customer, berat, jml_item ) VALUES ( 101, 2, 2, 18, 11 )  
    INTO LAUNDRY ( id_laundry, id_pegawai, id_customer, berat, jml_item ) VALUES ( 102, 3, 3, 4, 10 ) 
    INTO LAUNDRY ( id_laundry, id_pegawai, id_customer, berat, jml_item ) VALUES ( 103, 4, 4, 9, 14 )
    INTO LAUNDRY ( id_laundry, id_pegawai, id_customer, berat, jml_item ) VALUES ( 104, 5, 5, 10, 30 )   
SELECT * FROM dual;

INSERT ALL 
    INTO DETAIL_LAUNDRY ( id_laundry, nama_item, kode_item, harga, tgl_selesai, tgl_terima ) VALUES ( 101, 'baju', 123, 90000, TO_DATE('2023-06-01', 'yyyy-mm-dd'),TO_DATE('2023-06-11', 'yyyy-mm-dd')) 
    INTO DETAIL_LAUNDRY ( id_laundry, nama_item, kode_item, harga, tgl_selesai, tgl_terima ) VALUES ( 102, 'selimut', 124, 110000, TO_DATE('2023-06-02', 'yyyy-mm-dd'),TO_DATE('2023-06-12', 'yyyy-mm-dd'))   
    INTO DETAIL_LAUNDRY ( id_laundry, nama_item, kode_item, harga, tgl_selesai, tgl_terima ) VALUES ( 103, 'baju kerja', 125, 100000, TO_DATE('2023-06-01', 'yyyy-mm-dd'), TO_DATE('2023-06-13', 'yyyy-mm-dd'))  
    INTO DETAIL_LAUNDRY ( id_laundry, nama_item, kode_item, harga, tgl_selesai, tgl_terima ) VALUES ( 104, 'seragam sekolah', 126, 140000, TO_DATE('2023-06-02', 'yyyy-mm-dd'), TO_DATE('2023-06-12', 'yyyy-mm-dd'))  
    INTO DETAIL_LAUNDRY ( id_laundry, nama_item, kode_item, harga, tgl_selesai, tgl_terima ) VALUES ( 100, 'seragam olahraga', 127, 300000, TO_DATE('2023-06-03', 'yyyy-mm-dd'), TO_DATE('2023-06-14', 'yyyy-mm-dd'))  
SELECT * FROM dual;

INSERT ALL 
    INTO PEMBAYARAN ( id_pembayaran, id_laundry, total_harga ) VALUES ( 10, 101, 90000)  
    INTO PEMBAYARAN ( id_pembayaran, id_laundry, total_harga ) VALUES ( 11, 103, 100000) 
    INTO PEMBAYARAN ( id_pembayaran, id_laundry, total_harga ) VALUES ( 12, 102, 110000)   
    INTO PEMBAYARAN ( id_pembayaran, id_laundry, total_harga ) VALUES ( 13, 100, 300000)  
    INTO PEMBAYARAN ( id_pembayaran, id_laundry, total_harga ) VALUES ( 14, 104, 140000)    
SELECT * FROM dual;

--INNER JOIN
SELECT laundry.id_customer, laundry.id_laundry, detail_laundry.harga
FROM laundry 
INNER JOIN detail_laundry
ON laundry.id_laundry = detail_laundry.id_laundry;

--subquery
SELECT
    MAX(total_harga )
FROM pembayaran;

--subquery
SELECT
    id_laundry, nama_item, harga, tgl_terima
FROM detail_laundry
WHERE harga >= 100000;

--subquery
SELECT id_pegawai as kode_pegawai,
       nama_pegawai as nama,
       telp_pegawai as telepon 
from pegawai
order by id_pegawai asc;

--buat VIEW pembayaran_max
CREATE OR REPLACE VIEW Pembayaran_max AS
  SELECT id_laundry, harga, tgl_terima
  FROM detail_laundry
  WHERE harga = 300000;

--Panggil view pembayaran_max
SELECT * 
FROM Pembayaran_max

-- Hapus VIEW pembayaran_max
drop view Pembayaran_max

--VIEW
CREATE OR REPLACE VIEW Pengambilan_baju AS 
  SELECT tgl_terima, nama_item, harga 
  FROM detail_laundry
  WHERE nama_item = 'baju';

--Panggil view pengambilan baju
SELECT *
FROM pengambilan_baju

--hapus view pengambilan_baju
drop view pengambilan_baju

--FUNCTION UNTUK MENCARI NAMA CUSTOMER BERDASARKAN ID_CUSTOMER DI TABEL CUSTOMER
CREATE OR REPLACE FUNCTION get_nama_customer
(c_id IN customer.id_customer%TYPE)
    RETURN VARCHAR2 IS
        v_nama customer.nama_customer%TYPE := '';
BEGIN
       SELECT nama_customer INTO v_nama FROM customer
       WHERE id_customer = c_id;
    RETURN v_nama;
EXCEPTION
       WHEN NO_DATA_FOUND THEN RETURN NULL;
END get_nama_customer;

--MENCETAK NAMA DENGAN MEMANGGIL ID_customer di ID no 2
	DECLARE v_nama customer.nama_customer%type;
	BEGIN
	      v_nama := get_nama_customer(2); 
	     DBMS_OUTPUT.PUT_LINE(v_nama); 
	END;


--PROCEDURE UNTUK MENAMBAHKAN BARIS DI PEGAWAI
CREATE OR REPLACE PROCEDURE add_pegawai AS
    tambah_pegawai pegawai.id_pegawai%TYPE;
BEGIN
INSERT INTO pegawai(id_pegawai, telp_pegawai , nama_pegawai)
VALUES(6, '08214567876', 'ROBBY');
DBMS_OUTPUT.PUT_LINE('Inserted '|| SQL%ROWCOUNT || ' row.');
END; 

--pemanggilan procedure
BEGIN
     add_pegawai;
END;

--TRIGGERS
/*TRIGGERS INI BERFUNGSI KALAU INSERT , DELETE , UPDATE 
DATA PADA TABEL LAUNDRY PADA HARI SABTU DAN MINGGU AKAN MUNCUL ERROR
*/
CREATE OR REPLACE TRIGGER secure_laundry
BEFORE INSERT OR DELETE OR UPDATE ON laundry
BEGIN
   IF TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN') THEN
        IF DELETING THEN RAISE_APPLICATION_ERROR
              (-20501,'You may delete from PENJUALAN table only during business hours');
        ELSIF INSERTING THEN RAISE_APPLICATION_ERROR
              (-20502,'You may insert into PENJUALAN table only during business hours');
        ELSIF UPDATING THEN RAISE_APPLICATION_ERROR
              (-20503,'You may update PENJUALAN table only during business hours');
        END IF; 
   END IF;
END;

--Hapus Trigger
DROP TRIGGER secure_laundry; 
