insert into ROOM(RoomNumber)
values(101)
go
insert into ROOM(RoomNumber)
values(204)
go
insert into ROOM(RoomNumber)
values(301)
go
insert into SENSORTYPE(Type) 
values('pt-100')
go
insert into SENSORTYPE(Type) 
values('thermoresistor')
go
insert into SENSOR(RoomId, SensorTypeId) 
values(1,1)
go
insert into SENSOR(RoomId, SensorTypeId) 
values(2,1)
go
insert into SENSOR(RoomId, SensorTypeId) 
values(3,2)
go