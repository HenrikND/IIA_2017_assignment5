if EXISTS ( select name
			from sysobjects
			where name = 'ConvertType'
			and type = 'TR')
			drop trigger ConvertType
go


CREATE TRIGGER ConvertType ON LOG
	FOR UPDATE, INSERT
AS

DECLARE
@CelsiusValue float,
@FahrenheitValue float,
@LogId int

select @CelsiusValue =  CelsiusValue from inserted
select @FahrenheitValue = FahrenheitValue from inserted
select @LogId  = LogId from inserted

if @CelsiusValue is NOT null
update LOG set FahrenheitValue = ROUND(@CelsiusValue*1.8+32,1) where LogId = @LogId
else
update LOG set CelsiusValue = ROUND((@FahrenheitValue-32)/1.8,1) where LogId = @LogId

go