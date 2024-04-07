if EXISTS ( select name
			from sysobjects
			where name = 'CalcAvg'
			and type = 'TR')
			drop trigger CalcAvg
go


CREATE TRIGGER CalcAvg ON LOG
	FOR UPDATE, INSERT
AS

declare
@Average float,
@SensorId int

select @SensorId = SensorId from inserted

select @Average = ROUND(AVG(CelsiusValue),1) from LOG where SensorId = @SensorId

update SENSOR set AverageValueCelsius = @Average where SensorId = @SensorId
