--câu 1a
create proc lab5_cau1_a @name nvarchar(20)
as
	begin
		print 'welcome to đại học nhàn lắm: ' + @name
	end
exec lab5_cau1_a 'Đoan Trang'
go
--câu 1b
create proc lab5_cau1_b @so1 int, @so2 int
as
	begin
		declare @tong int = 0;
		set @tong = @so1 + @so2 
		print 'tong: ' + cast(@tong as varchar(10))
	end

exec lab5_cau1_b 7,8
go
--câu 1c
create proc lab5_cau1_c @l int
as
	begin
		declare @tong int = 0, @i int = 0;
		while @i < @l
			begin
				set @tong = @tong + @i
				set @i = @i + 2
			end
		print 'tổng: ' + cast(@tong as varchar(10))
	end
exec lab5_cau1_c 15
go
--câu 1d
create proc lab5_cau1_d @a int, @b int
as
	begin
		while (@a != @b)
			begin
				if(@a > @b)
					set @a = @a -@b
				else
					set @b = @b - @a
			end
			return @a
	end
declare @l int
exec @l = lab5_cau1_d 5,7 
print @l
go
--câu 2a
create proc lab5_cau2_a @MaNV varchar(20)
as
	begin
		select * from NHANVIEN where MANV = @MaNV
	end
exec lab5_cau2_a '003'
go
--câu 2b
select count(MANV), MADA, TENPHG from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
where MADA = 2
group by TENPHG,MADA

alter proc lab5_cau2_b @manv int
as
begin
		select count(MANV) as 'so luong', MADA, TENPHG from NHANVIEN
		inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
		inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
		where MADA = @manv
		group by TENPHG,MADA
end
exec lab5_cau2_b 10 
go
---câu 3
create proc sp_InsertPB @MaPB int , @TenPB nvarchar(15),
		@MaTP nvarchar(9), @NgayNhanChuc date
as
	begin
		if(exists(select * from PhongBan where MaPHG =  @MaPB))
			print 'Them That Bai'
		else
			begin
				insert into PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
				values(@MaPB, @TenPB , @MaTP, @NgayNhanChuc)
				print 'Them Thanh Cong'
			end
	end
exec sp_InsertPB '8', 'CNTT', '008', '2020-10-06'
select * from PHONGBAN
--CAU 3B
create proc sp_CapNhatPhongBan
    @OldTenPB nvarchar (15),
    @MaPB int , 
	@TenPB nvarchar(15),
    @MaTP INT, 
	@NgayNhanChuc date
as
begin
   UPDATE [dbo].[PHONGBAN]
   SET [TENPHG] = @TenPB
      ,[MAPHG] = @MaPB
      ,[TRPHG] = @MaTP
      ,[NG_NHANCHUC] = @NgayNhanChuc
 WHERE TENPHG = @OldTenPB;
end;

exec [dbo].[sp_CapNhatPhongBan] 'CNTT', 'IT', 10, '005', '1-1-2020';