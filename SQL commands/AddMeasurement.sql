CREATE PROCEDURE AddMeasurement
	-- Add the parameters for the stored procedure here
	@Value float,
	@Unit varchar(30),
	@SensorId int
AS

DECLARE
@TimeStamp datetime = getdate(),

IF(@Unit = 'Celsius')
	BEGIN
	insert into LOG (CelsiusValue, TimeStamp, SensorId)
	values(@Value, @TimeStamp, @SensorId)
	END

ELSE
	BEGIN
	insert into LOG (FahrenheitValue, TimeStamp, SensorId)
	values(@Value, @TimeStamp, @SensorId)
	END

